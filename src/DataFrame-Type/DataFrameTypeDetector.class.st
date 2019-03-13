"
I am a smart type detector. I receive a column of string values such as #('5' '-1' '0.1') or #('1:10' '2:20' '3:30'), detect the type to which all values in that column can be converted, and convert all values to that type. For example, #(5.0 -1.0 0.1) and #(1:10 am 2:20 am 3:30 am).

My typical application is to detect data types of data frame columns after that data frame was read from a CSV file.

I support the following types: Integer, Float, Boolean, Time, DateAndTime, String
"
Class {
	#name : #DataFrameTypeDetector,
	#superclass : #Object,
	#category : #'DataFrame-Type'
}

{ #category : #testing }
DataFrameTypeDetector >> canAllBeBoolean: aDataSeries [
	^ aDataSeries
		detect: [ :each | (each ~= 'true') and: (each ~= 'false') ]
		ifFound: [ false ]
		ifNone: [ true ].
]

{ #category : #testing }
DataFrameTypeDetector >> canAllBeDateAndTime: aDataSeries [
	[ aDataSeries do: #asDateAndTime ]
		on: Error do: [ ^ false ].
	^ true
]

{ #category : #testing }
DataFrameTypeDetector >> canAllBeNumber: aDataSeries [
	| regex |
	regex := '^[-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?$' asRegex.
	
	^ aDataSeries
		detect: [ :each | [ (regex matches: each) not ] on: Error do: [ ^ false ] ]
		ifFound: [ false ]
		ifNone: [ true ]
]

{ #category : #testing }
DataFrameTypeDetector >> canAllBeTime: aDataSeries [
	[ aDataSeries do: #asTime ]
		on: Error do: [ ^ false ].
	^ true
]

{ #category : #testing }
DataFrameTypeDetector >> canAnyBeFloat: aDataSeries [
	^ aDataSeries
		detect: [ :each | each asNumber isFloat ]
		ifFound: [ true ]
		ifNone: [ false ].
]

{ #category : #converting }
DataFrameTypeDetector >> convertToBoolean: aDataSeries [
	^ aDataSeries collect: [ :each | each = 'true' ]
]

{ #category : #converting }
DataFrameTypeDetector >> convertToDateAndTime: aDataSeries [
	^ aDataSeries collect: #asDateAndTime
]

{ #category : #converting }
DataFrameTypeDetector >> convertToFloat: aDataSeries [
	^ aDataSeries collect: [ :each | each asNumber asFloat ]
]

{ #category : #converting }
DataFrameTypeDetector >> convertToInteger: aDataSeries [
	^ aDataSeries collect: [ :each | each asNumber asInteger ]
]

{ #category : #converting }
DataFrameTypeDetector >> convertToTime: aDataSeries [
	^ aDataSeries collect: #asTime
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
	aDataFrame columnNames do: [ :columnName |
		aDataFrame column: columnName put: (
			self detectColumnTypeAndConvert: (aDataFrame column: columnName)) asArray ].
		
	aDataFrame rowNames: (self detectColumnTypeAndConvert: aDataFrame rowNames).
]
