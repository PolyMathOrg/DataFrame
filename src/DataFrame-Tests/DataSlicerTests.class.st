Class {
	#name : #DataSlicerTests,
	#superclass : #TestCase,
	#instVars : [
		'df',
		'series'
	],
	#category : #'DataFrame-Tests'
}

{ #category : #initialization }
DataSlicerTests >> setUp [

	df := DataFrame fromRows: #(
		(5.1 3.5 1.4 0.2 setosa)
		(4.9 3 1.4 0.2 setosa)
		(4.7 3.2 1.3 0.2 setosa)
		(7 3.2 4.7 1.4 versicolor)
		(6.4 3.2 4.5 1.5 versicolor)
		(6.9 3.1 4.9 1.5 versicolor)
		(6.3 3.3 6 2.5 virginica)
		(5.8 2.7 5.1 1.9 virginica)
		(7.1 3 5.9 2.1 virginica)).
		
	df columnNames: #(sepalLength sepalWidth petalLength petalWidth species).
	series := df column: #sepalLength.
]

{ #category : #tests }
DataSlicerTests >> testDataFrameHead [

	| actual expected |
	
	expected := DataFrame fromRows: #(
		(5.1 3.5 1.4 0.2 setosa)
		(4.9 3 1.4 0.2 setosa)
		(4.7 3.2 1.3 0.2 setosa)
		(7 3.2 4.7 1.4 versicolor)
		(6.4 3.2 4.5 1.5 versicolor)).
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
		(6.4 3.2 4.5 1.5 versicolor)
		(6.9 3.1 4.9 1.5 versicolor)
		(6.3 3.3 6 2.5 virginica)
		(5.8 2.7 5.1 1.9 virginica)
		(7.1 3 5.9 2.1 virginica)).
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
		(6.3 3.3 6 2.5 virginica)
		(5.8 2.7 5.1 1.9 virginica)
		(7.1 3 5.9 2.1 virginica)).
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
	
	expected := #(5.1 4.9 4.7 7 6.4) asDataSeries.
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
	
	expected := #(6.4 6.9 6.3 5.8 7.1) asDataSeries.
	expected name: series name.
	expected keys:
		(series size - series defaultHeadTailSize + 1 to: series size).
	
	actual := series tail.

	self assert: actual equals: expected.
]

{ #category : #tests }
DataSlicerTests >> testDataSeriesTailN [

	| actual expected |
	
	expected := #(6.3 5.8 7.1) asDataSeries.
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
