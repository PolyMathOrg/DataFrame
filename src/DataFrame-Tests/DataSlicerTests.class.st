Class {
	#name : #DataSlicerTests,
	#superclass : #TestCase,
	#instVars : [
		'df',
		'series'
	],
	#category : 'DataFrame-Tests'
}

{ #category : #initialization }
DataSlicerTests >> setUp [

	df := DataFrame loadIris.
	series := df column: #sepal_length.
]

{ #category : #tests }
DataSlicerTests >> testDataFrameHead [

	| actual expected |
	
	expected := DataFrame fromRows: #(
		(5.1 3.5 1.4 0.2 setosa)
		(4.9 3 1.4 0.2 setosa)
		(4.7 3.2 1.3 0.2 setosa)
		(4.6 3.1 1.5 0.2 setosa)
		(5 3.6 1.4 0.2 setosa)).
	expected columnNames: df columnNames.
	expected rowNames: (1 to: df defaultHeadTailSize).
	
	actual := df head.
			
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSlicerTests >> testDataFrameHeadN [

	| actual expected |
	
	expected := DataFrame fromRows: #(
		(5.1 3.5 1.4 0.2 setosa)
		(4.9 3 1.4 0.2 setosa)
		(4.7 3.2 1.3 0.2 setosa)).
	expected columnNames: df columnNames.
	expected rowNames: (1 to: 3).
	
	actual := df head: 3.
			
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSlicerTests >> testDataFrameTail [

	| actual expected rows |
	
	expected := DataFrame fromRows: #(
		(6.7 3 5.2 2.3 virginica)
		(6.3 2.5 5 1.9 virginica)
		(6.5 3 5.2 2 virginica)
		(6.2 3.4 5.4 2.3 virginica)
		(5.9 3 5.1 1.8 virginica)).
	expected columnNames: df columnNames.
	
	rows := df numberOfRows.
	expected rowNames:
		(rows - df defaultHeadTailSize + 1 to: rows).
	
	actual := df tail.
			
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSlicerTests >> testDataFrameTailN [

	| actual expected rows |
	
	expected := DataFrame fromRows: #(
		(6.5 3 5.2 2 virginica)
		(6.2 3.4 5.4 2.3 virginica)
		(5.9 3 5.1 1.8 virginica)).
	expected columnNames: df columnNames.
	
	rows := df numberOfRows.
	expected rowNames:
		(rows - 3 + 1 to: rows).
	
	actual := df tail: 3.
			
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSlicerTests >> testDataSeriesHead [

	| actual expected |
	
	expected := #(5.1 4.9 4.7 4.6 5) asDataSeries.
	expected name: series name.
	expected keys: (1 to: series defaultHeadTailSize).
	
	actual := series head.

	self assert: actual equals: expected.
]

{ #category : #tests }
DataSlicerTests >> testDataSeriesHeadN [

	| actual expected |
	
	expected := #(5.1 4.9 4.7) asDataSeries.
	expected name: series name.
	expected keys: (1 to: 3).
	
	actual := series head: 3.

	self assert: actual equals: expected.
]

{ #category : #tests }
DataSlicerTests >> testDataSeriesTail [

	| actual expected |
	
	expected := #(6.7 6.3 6.5 6.2 5.9) asDataSeries.
	expected name: series name.
	expected keys:
		(series size - series defaultHeadTailSize + 1 to: series size).
	
	actual := series tail.

	self assert: actual equals: expected.
]

{ #category : #tests }
DataSlicerTests >> testDataSeriesTailN [

	| actual expected |
	
	expected := #(6.5 6.2 5.9) asDataSeries.
	expected name: series name.
	expected keys:
		(series size - 3 + 1 to: series size).
	
	actual := series tail: 3.

	self assert: actual equals: expected.
]

{ #category : #tests }
DataSlicerTests >> testDefaultHeadTailSize [

	self assert: df defaultHeadTailSize equals: 5.
]
