Class {
	#name : #DataFrameQueriesTests,
	#superclass : #TestCase,
	#instVars : [
		'df'
	],
	#category : #'DataFrame-Tests'
}

{ #category : #initialization }
DataFrameQueriesTests >> setUp [

	df := DataFrame loadIris
]

{ #category : #initialization }
DataFrameQueriesTests >> testGroupbyAggregate [

	| actual expected |
	
	actual := df groupBy: #species aggregate: #sum.
	
	expected := DataFrame fromRows: #(
		(250.3 170.9 73.2 12.2)
		(296.8 138.5 213.0 66.3)
		(329.4 148.7 277.6 101.3)).
		
	expected columnNames: #(sepal_length sepal_width petal_length petal_width).
	expected rowNames: #(setosa versicolor virginica).
	
	self assert: actual closeTo: expected.
]

{ #category : #initialization }
DataFrameQueriesTests >> testSelectAllWhere [

	| actual |
	
	actual := df selectAllWhere: [ :species :sepal_width |
		species = #setosa and: sepal_width = 3 ].
	
	self assert: actual columnNames equals: df columnNames.
	self assert: actual rowNames equals: #(2 13 14 26 39 46).
]

{ #category : #initialization }
DataFrameQueriesTests >> testSelectGroupbyAggregate [

	| selectedCols actual expected |
	selectedCols := #(petal_length petal_width).
	
	actual := df
		select: selectedCols
		groupBy: #species
		aggregate: #sum.
	
	expected := DataFrame fromRows: #(
		(73.2 12.2)
		(213.0 66.3)
		(277.6 101.3)).
		
	expected columnNames: selectedCols.
	expected rowNames: #(setosa versicolor virginica).
	
	self assert: actual closeTo: expected.
]

{ #category : #initialization }
DataFrameQueriesTests >> testSelectWhere [

	| selectedCols actual |
	
	selectedCols := #(petal_width petal_length).
	
	actual := df
		select: selectedCols
		where: [ :species :sepal_width |
			species = #setosa and: sepal_width = 3 ].
	
	self assert: actual columnNames equals: selectedCols.
	self assert: actual rowNames equals: #(2 13 14 26 39 46).
]

{ #category : #initialization }
DataFrameQueriesTests >> testSelectWhereGroupbyAggregate [

	| selectedCols actual expected |
	
	selectedCols := #(petal_width petal_length).
	
	actual := df select: #(sepal_length species)
		where: [ :petal_length :petal_width |
			(petal_length < 4.9 and: petal_length > 1.6) and:
			(petal_width < 0.4 or: petal_width > 1.5) ]
		groupBy: #species
		aggregate: #sum.
		
	expected := DataFrame fromColumns: #((15.9 18.2 17.1)).
	expected columnNames: #(sepal_length).
	expected rowNames: #(setosa versicolor virginica).

	self assert: actual closeTo: expected.
]
