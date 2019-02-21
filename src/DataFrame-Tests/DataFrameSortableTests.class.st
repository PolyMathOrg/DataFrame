Class {
	#name : #DataFrameSortableTests,
	#superclass : #TestCase,
	#instVars : [
		'df',
		'columnNames'
	],
	#category : 'DataFrame-Tests'
}

{ #category : #initialization }
DataFrameSortableTests >> setUp [

	df := DataFrame fromRows: #(
		('Barcelona' 1.609 true)
		('Lviv' 0.724 true)
		('London' 8.788 false)
   		('Dubai' 2.789 true)).
		
	columnNames := #(City Population BeenThere).
		
	df rowNames: #(A B C D).
	df columnNames: columnNames.
]

{ #category : #initialization }
DataFrameSortableTests >> testOrderBy [

	| expected |
	
	expected := DataFrame fromRows: #(
		(Lviv 0.724 true)
		(Barcelona 1.609 true)
   		(Dubai 2.789 true)
		(London 8.788 false)).
		
	expected columnNames: columnNames.
	expected rowNames: #(B A D C).
	
	df orderBy: #Population.
	
	self assert: df equals: expected.
]

{ #category : #initialization }
DataFrameSortableTests >> testOrderByUsing [

	| expected |
	
	expected := DataFrame fromRows: #(
		(London 8.788 false)
		(Dubai 2.789 true)
		(Barcelona 1.609 true)
		(Lviv 0.724 true)).
		
	expected columnNames: columnNames.
	expected rowNames: #(C D A B).
	
	df orderBy: #Population using: [ :a :b | a >= b ].
	
	self assert: df equals: expected.
]
