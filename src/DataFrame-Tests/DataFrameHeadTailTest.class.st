Class {
	#name : #DataFrameHeadTailTest,
	#superclass : #TestCase,
	#instVars : [
		'df',
		'series'
	],
	#category : #'DataFrame-Tests'
}

{ #category : #initialization }
DataFrameHeadTailTest >> setUp [

	df := DataFrame withRows: #(
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
DataFrameHeadTailTest >> testDataFrameHead [

	| actual expected |
	
	expected := DataFrame withRows: #(
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
DataFrameHeadTailTest >> testDataFrameHeadN [

	| actual expected |
	
	expected := DataFrame withRows: #(
		(5.1 3.5 1.4 0.2 setosa)
		(4.9 3 1.4 0.2 setosa)
		(4.7 3.2 1.3 0.2 setosa)).
	expected columnNames: df columnNames.
	expected rowNames: (1 to: 3).
	
	actual := df head: 3.
			
	self assert: actual equals: expected.
]

{ #category : #tests }
DataFrameHeadTailTest >> testDataFrameTail [

	| actual expected rows |
	
	expected := DataFrame withRows: #(
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
DataFrameHeadTailTest >> testDataFrameTailN [

	| actual expected rows |
	
	expected := DataFrame withRows: #(
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
DataFrameHeadTailTest >> testDefaultHeadTailSize [

	self assert: df defaultHeadTailSize equals: 5.
]
