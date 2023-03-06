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
DataFrameTypeDetector >> canAllBeBoolean: anArray [
	"Checks to see if all of the values in the column are strings of true or false (case insensitive) or nil"

	^ anArray allSatisfy: [ :each | each isNil or: [ each isString and: [ (each sameAs: 'true') | (each sameAs: 'false') ] ] ]
]

{ #category : #testing }
DataFrameTypeDetector >> canAllBeDateAndTime: anArray [

	[ anArray do: [ :ele | ele ifNotNil: [ ele asDateAndTime ] ] ]
		on: Error
		do: [ ^ false ].
	^ true
]

{ #category : #testing }
DataFrameTypeDetector >> canAllBeNumber: anArray [

	^ anArray allSatisfy: [ :each | each isNil or: [ each isNumber or: [ NumberParser isNumber: each ] ] ]
]

{ #category : #testing }
DataFrameTypeDetector >> canAllBeTime: anArray [

	[ anArray do: [ :ele | ele ifNotNil: [ ele asTime ] ] ]
		on: Error
		do: [ ^ false ].
	^ true
]

{ #category : #testing }
DataFrameTypeDetector >> canAnyBeFloat: anArray [

	^ anArray anySatisfy: [ :each | each isNil or: [ each asNumber isFloat ] ]
]

{ #category : #accessing }
DataFrameTypeDetector >> columnTypes [

	^ columnTypes
]

{ #category : #accessing }
DataFrameTypeDetector >> columnTypes: aCollection [

	columnTypes := aCollection
]

{ #category : #converting }
DataFrameTypeDetector >> convertToBoolean: anArray [

	^ anArray collect: [ :each | each ifNotNil: [ each asLowercase = 'true' ] ]
]

{ #category : #converting }
DataFrameTypeDetector >> convertToDateAndTime: anArray [

	^ anArray collect: [ :ele | ele ifNotNil: [ ele asDateAndTime ] ]
]

{ #category : #converting }
DataFrameTypeDetector >> convertToFloat: anArray [

	^ anArray collect: [ :each | each ifNotNil: [ each asNumber asFloat ] ]
]

{ #category : #converting }
DataFrameTypeDetector >> convertToInteger: anArray [

	^ anArray collect: [ :each | each ifNotNil: [ each asNumber asInteger ] ]
]

{ #category : #converting }
DataFrameTypeDetector >> convertToTime: anArray [

	^ anArray collect: [ :ele | ele ifNotNil: [ ele asTime ] ]
]

{ #category : #'public API' }
DataFrameTypeDetector >> detectColumnTypeAndConvert: anArray [

	(self canAllBeNumber: anArray) ifTrue: [
		^ (self canAnyBeFloat: anArray)
			  ifTrue: [ self convertToFloat: anArray ]
			  ifFalse: [ self convertToInteger: anArray ] ].

	(self canAllBeBoolean: anArray) ifTrue: [ ^ self convertToBoolean: anArray ].

	(self canAllBeDateAndTime: anArray) ifTrue: [ ^ self convertToDateAndTime: anArray ].

	(self canAllBeTime: anArray) ifTrue: [ ^ self convertToTime: anArray ].

	^ anArray
]

{ #category : #'public API' }
DataFrameTypeDetector >> detectTypesAndConvert: aDataFrame [

	aDataFrame columns with: aDataFrame columnNames do: [ :column :columnName |
		| thisColumnType |
		"Get the user given column type for this column name and if it wasn't
			 given then use the default type detection"
		thisColumnType := columnTypes at: columnName ifAbsent: [ [ :array | self detectColumnTypeAndConvert: array ] ].
		"We allow users to submit either a string which is one of the standard
			 types that we know how to convert or a block which is for custom type
			 conversion. Test if it's a block here and if not assume that we can
			 look it up in the type mapping and assign one of the standard type
			 converting blocks."
		thisColumnType isBlock ifFalse: [ thisColumnType := typeMapping at: thisColumnType ].
		"Assign the column with the converted type by passing the original
			 column to the block for type conversion"
		aDataFrame column: columnName put: (thisColumnType value: column) ].
	aDataFrame rowNames: (self detectColumnTypeAndConvert: aDataFrame rowNames)
]

{ #category : #initialization }
DataFrameTypeDetector >> initialize [

	super initialize.
	columnTypes := Dictionary new.
	typeMapping := Dictionary newFrom: {
			               (Boolean -> [ :array | self convertToBoolean: array ]).
			               (Float -> [ :array | self convertToFloat: array ]).
			               (Integer -> [ :array | self convertToInteger: array ]).
			               (Time -> [ :array | self convertToTime: array ]).
			               (DateAndTime -> [ :array | self convertToDateAndTime: array ]).
			               (String -> [ :array | array ]).
			               (nil -> [ :array | self detectColumnTypeAndConvert: array ]) }
]
