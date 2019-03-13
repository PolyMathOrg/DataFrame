Class {
	#name : #DataFrameAggrGroupTest,
	#superclass : #TestCase,
	#instVars : [
		'df'
	],
	#category : #'DataFrame-Tests'
}

{ #category : #initialization }
DataFrameAggrGroupTest >> setUp [

	df := DataFrame withRows:
		#((16.99 1.01 'Female' 'No' 'Sun' 'Dinner' 2)
		  (10.34 1.66 'Male' 'No' 'Sun' 'Dinner' 3)
		  (21.01 3.5 'Male' 'No' 'Sun' 'Dinner' 3)
		  (23.68 3.31 'Male' 'No' 'Sun' 'Dinner' 2)
		  (24.59 3.61 'Female' 'No' 'Sun' 'Dinner' 4)).
		
	df columnNames: #('total_bill' 'tip' 'sex' 'smoker' 'day' 'time' 'size').
]

{ #category : #initialization }
DataFrameAggrGroupTest >> testAggregateAverage [

	| expected actual |
	
	expected := #(18.3433 20.79) asDataSeries.
	expected keys: #(Male Female).
	
	actual := (df group: #total_bill by: #sex) average.
	
	self assert: actual closeTo: expected.
]

{ #category : #initialization }
DataFrameAggrGroupTest >> testAggregateMax [

	| expected actual |
	
	expected := #(23.68 24.59) asDataSeries.
	expected keys: #(Male Female).
	
	actual := (df group: #total_bill by: #sex) max.
	
	self assert: actual equals: expected.
]

{ #category : #initialization }
DataFrameAggrGroupTest >> testAggregateMin [

	| expected actual |
	
	expected := #(10.34 16.99) asDataSeries.
	expected keys: #(Male Female).
	
	actual := (df group: #total_bill by: #sex) min.
	
	self assert: actual equals: expected.
]

{ #category : #initialization }
DataFrameAggrGroupTest >> testDataFrameGroupedPrintOn [

	| expected actual |
	
	expected := String new writeStream.
	expected
		nextPutAll: 'a DataFrameGrouped'; cr;
		nextPutAll: 'Male: a DataFrame (3@6)'; cr;
		nextPutAll: 'Female: a DataFrame (2@6)'.
	expected := expected contents.
	
	actual := String new writeStream.
	(df groupBy: #sex) printOn: actual.
	actual := actual contents.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataFrameAggrGroupTest >> testGroupSeriesBySeries [

	| femaleGroup maleGroup expectedSeries actualSeries |
	
	femaleGroup := #(16.99 24.59) asDataSeries.
	maleGroup := #(10.34 21.01 23.68) asDataSeries.
	
	expectedSeries := { maleGroup . femaleGroup } asDataSeries.
	expectedSeries keys: #(Male Female).
	
	actualSeries := (df group: #total_bill by: #sex) groups.
	
self assert: actualSeries equals: expectedSeries.
]
