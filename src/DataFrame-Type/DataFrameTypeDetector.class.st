"
I am a smart type detector. I receive a column of string values such as #('5' '-1' '0.1') or #('1:10' '2:20' '3:30'), detect the type to which all values in that column can be converted, and convert all values to that type. For example, #(5.0 -1.0 0.1) and #(1:10 am 2:20 am 3:30 am).

My typical application is to detect data types of data frame columns after that data frame was read from a CSV file.

I support the following types: Integer, Float, Boolean, Time, DateAndTime, String.

Instead of guessing the column types I can also be given a mapping of the column names and their types
in which case I skip detection and just convert. To set the types use my `columnTypes:` message.

    detector := DataFrameTypeDetector new.
    detector columnTypes: { 'columnName1' -> String. 'columnName2' -> Boolean } asDictionary.

    detector detectTypesAndConvert: aDataFrame

The keys of this mapping must be the column name and the values can be either a block (to perform custom type conversion) or one of the following strings that implement one of my standard type conversions:

- String: this does not perform any conversion.
- Integer: convert to an Integer object.
- Float: convert to a Float object.
- Boolean: convert to a Boolean object.
- DateAndTime: convert to a DateAndTime object.
- Time: convert to a Time object.
- nil: will attempt to guess the type of the column from one of the listed types above. This is the default if no conversion is given.
	
As well as the standard types I can also perform custom type conversion if the value is a block.

    types := { 'columnName' -> [:series | series collect: [:each | each asCustomType]]. } asDictionary.
    detector columnTypes: types	
    detector detectTypesAndConvert: aDataFrame

The block takes a single argument, the column, and should return the column as well. I also handle 
mixing the standard conversion types and custom converters in the provided types dictionary:

    types := { 'columnName2' -> Integer . 'columnName2' -> [:series | series collect: [:each | each asCustomType]]. } asDictionary.
    detector columnTypes: types	
    detector detectTypesAndConvert: aDataFrame
 
"
Class {
	#name : #DataFrameTypeDetector,
	#superclass : #Object,
	#instVars : [
		'columnTypes',
		'typeMapping'
	],
	#category : #'DataFrame-Type'
}

{ #category : #testing }
DataFrameTypeDetector >> canAllBeBoolean: aDataSeries [
   "Checks to see if all of the values in the column are strings of true or false (case insensitive) or nil"
	^ aDataSeries
		detect: [ :each | 
			|eachLower | 
			eachLower := [each asLowercase] on: Error do: [eachLower := each].
			((eachLower = 'true') | (eachLower = 'false') | (eachLower isNil)) not . 
			]
		ifFound: [ false ]
		ifNone: [ true ].
]

{ #category : #testing }
DataFrameTypeDetector >> canAllBeDateAndTime: aDataSeries [
	[ aDataSeries do: [ :ele | ele isNil ifFalse: [ ele asDateAndTime ]] ]
		on: Error do: [ ^ false ].
	^ true
]

{ #category : #testing }
DataFrameTypeDetector >> canAllBeNumber: aDataSeries [

	| regex |
	regex := '^[-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?$' asRegex.

	^ aDataSeries
		  detect: [ :each | 
			  [ each ifNil: [ false ] ifNotNil: [ (regex matches: each) not ] ]
				  on: Error
				  do: [ ^ false ] ]
		  ifFound: [ false ]
		  ifNone: [ true ]
]

{ #category : #testing }
DataFrameTypeDetector >> canAllBeTime: aDataSeries [
	[ aDataSeries do: [ :ele | ele isNil ifFalse: [ ele asTime ] ] ]
		on: Error do: [ ^ false ].
	^ true
]

{ #category : #testing }
DataFrameTypeDetector >> canAnyBeFloat: aDataSeries [
	^ aDataSeries
		detect: [ :each | each isNil ifTrue: [ false ] ifFalse: [ (each asNumber isFloat) ] ]
		ifFound: [ true ]
		ifNone: [ false ].
]

{ #category : #accessing }
DataFrameTypeDetector >> columnTypes [
	^columnTypes
]

{ #category : #accessing }
DataFrameTypeDetector >> columnTypes: aCollection [
	columnTypes := aCollection
]

{ #category : #converting }
DataFrameTypeDetector >> convertToBoolean: aDataSeries [
	^ aDataSeries collect: [ :each |
		each isNil
			ifFalse: [ each asLowercase = 'true' ] ]
]

{ #category : #converting }
DataFrameTypeDetector >> convertToDateAndTime: aDataSeries [
	^ aDataSeries collect: [ :ele | ele isNil ifFalse: [ ele asDateAndTime ] ]
]

{ #category : #converting }
DataFrameTypeDetector >> convertToFloat: aDataSeries [
	^ aDataSeries collect: [ :each | each isNil ifFalse: [ each asNumber asFloat ] ]
]

{ #category : #converting }
DataFrameTypeDetector >> convertToInteger: aDataSeries [
	^ aDataSeries collect: [ :each | each isNil ifFalse: [ each asNumber asInteger ] ]
]

{ #category : #converting }
DataFrameTypeDetector >> convertToTime: aDataSeries [
	^ aDataSeries collect: [ :ele | ele isNil ifFalse: [ ele asTime ] ]
]

{ #category : #'public API' }
DataFrameTypeDetector >> detectColumnTypeAndConvert: aDataSeries [
	(self canAllBeNumber: aDataSeries) ifTrue: [ 
		(self canAnyBeFloat: aDataSeries)
			ifTrue: [ ^ self convertToFloat: aDataSeries ]
			ifFalse: [ ^ self convertToInteger: aDataSeries ] ].
		
	(self canAllBeBoolean: aDataSeries) ifTrue: [ 
		^ self convertToBoolean: aDataSeries ].
	
	(self canAllBeDateAndTime: aDataSeries) ifTrue: [ 
		^ self convertToDateAndTime: aDataSeries ].
	
	(self canAllBeTime: aDataSeries) ifTrue: [ 
		^ self convertToTime: aDataSeries ].
	
	^ aDataSeries
]

{ #category : #'public API' }
DataFrameTypeDetector >> detectTypesAndConvert: aDataFrame [
	aDataFrame columnNames
		do: [ :columnName | 
			| thisColumnType |
			"Get the user given column type for this column name and if it wasn't
			 given then use the default type detection"
			thisColumnType := columnTypes
				at: columnName
				ifAbsent: [ [:array | self detectColumnTypeAndConvert: array ]].
			"We allow users to submit either a string which is one of the standard 
			 types that we know how to convert or a block which is for custom type
			 conversion. Test if it's a block here and if not assume that we can
			 look it up in the type mapping and assign one of the standard type
			 converting blocks."
			thisColumnType isBlock
				ifFalse: [ thisColumnType := typeMapping at: thisColumnType ].
			"Assign the column with the converted type by passing the original
			 column to the block for type conversion"
			aDataFrame
				column: columnName
				put: (thisColumnType value: (aDataFrame column: columnName)) asArray ].
	aDataFrame
		rowNames: (self detectColumnTypeAndConvert: aDataFrame rowNames)
]

{ #category : #initialization }
DataFrameTypeDetector >> initialize [
	columnTypes := Dictionary new.
	typeMapping := Dictionary
		newFrom:
			{(Boolean -> [ :array | self convertToBoolean: array ]).
			(Float -> [ :array | self convertToFloat: array ]).
			(Integer -> [ :array | self convertToInteger: array ]).
			(Time -> [ :array | self convertToTime: array ]).
			(DateAndTime -> [ :array | self convertToDateAndTime: array ]).
			(String -> [ :array | array ]).
			(nil -> [ :array | self detectColumnTypeAndConvert: array ])}.
]
