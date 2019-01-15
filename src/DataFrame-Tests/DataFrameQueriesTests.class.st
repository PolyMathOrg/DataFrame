Class {
	#name : #DataFrameQueriesTests,
	#superclass : #TestCase,
	#instVars : [
		'df'
	],
	#category : 'DataFrame-Tests'
}

{ #category : #initialization }
DataFrameQueriesTests >> setUp [

	df := DataFrame fromRows: #(
		(x 10 0.25 0.1)
		(y 20 0.75 0.4)
		(x 40 0.3 0.2)
		(y 35 0.15 0.1)
		(x 10 0 0)).
		
	df columnNames: #(a b c d).
]

{ #category : #initialization }
DataFrameQueriesTests >> testGroupbyAggregate [

	| actual expected |
	
	actual := df groupBy: #a aggregate: #sum.
	
	expected := DataFrame fromRows: #(
		(60 0.55 0.3)
		(55 0.9 0.5)).
		
	expected columnNames: #(b c d).
	expected rowNames: #(x y).
	
	self assert: actual closeTo: expected.
]

{ #category : #initialization }
DataFrameQueriesTests >> testSelectAllWhere [

	| actual |
	
	actual := df selectAllWhere: [ :a :b |
		a = #x and: b = 10 ].
	
	self assert: actual columnNames equals: df columnNames.
	self assert: actual rowNames equals: #(1 5).
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
