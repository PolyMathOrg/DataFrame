Class {
	#name : #DataFrameTypeDetectorTest,
	#superclass : #TestCase,
	#instVars : [
		'detector'
	],
	#category : #'DataFrame-Type-Tests'
}

{ #category : #running }
DataFrameTypeDetectorTest >> setUp [
	super setUp.
	detector := DataFrameTypeDetector new.
]

{ #category : #tests }
DataFrameTypeDetectorTest >> testBooleanColumn [
	| column expected actual |
	column := #('true' 'false' 'true' 'true') asDataSeries.
	expected := #(true false true true) asDataSeries.
	actual := detector detectColumnTypeAndConvert: column.
	self assert: actual equals: expected
]

{ #category : #tests }
DataFrameTypeDetectorTest >> testDateAndTimeColumn [
	| column expected actual |
	column := #('18 March 1996 1:10' '6 March 1996 2:30 am' '12 March 2019 14:24 am' '9 February 2019 00:00 am') asDataSeries.
	expected := (#('1996-03-18T01:10:00' '1996-03-06T02:30:00' '2019-03-12T14:24:00' '2019-02-09T00:00:00') collect: #asDateAndTime) asDataSeries.
	actual := detector detectColumnTypeAndConvert: column.
	self assert: actual equals: expected
]

{ #category : #tests }
DataFrameTypeDetectorTest >> testFloatColumn [
	| column expected actual |
	column := #('1.2' '3.3' '-10.1' '0.0') asDataSeries.
	expected := #(1.2 3.3 -10.1 0.0) asDataSeries.
	actual := detector detectColumnTypeAndConvert: column.
	self assert: actual equals: expected
]

{ #category : #tests }
DataFrameTypeDetectorTest >> testIntegerColumn [
	| column expected actual |
	column := #('1' '3' '-10' '0') asDataSeries.
	expected := #(1 3 -10 0) asDataSeries.
	actual := detector detectColumnTypeAndConvert: column.
	self assert: actual equals: expected
]

{ #category : #tests }
DataFrameTypeDetectorTest >> testMixedNumberColumn [
	| column expected actual |
	column := #('1' '3.3' '-10' '0') asDataSeries.
	expected := #(1.0 3.3 -10.0 0.0) asDataSeries.
	actual := detector detectColumnTypeAndConvert: column.
	self assert: actual equals: expected
]

{ #category : #tests }
DataFrameTypeDetectorTest >> testStringColumn [
	| column actual |
	column := #('lorem' 'ipsum' 'dolor' 'sit') asDataSeries.
	actual := detector detectColumnTypeAndConvert: column.
	self assert: actual equals: column
]

{ #category : #tests }
DataFrameTypeDetectorTest >> testTimeColumn [
	| column expected actual |
	column := #('1:10' '2:30' '14:24' '00:00') asDataSeries.
	expected := (#('1:10 am' '2:30 am' '14:24 am' '00:00 am') collect: #asTime) asDataSeries.
	actual := detector detectColumnTypeAndConvert: column.
	self assert: actual equals: expected
]
