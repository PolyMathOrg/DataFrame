Class {
	#name : #DataSeriesSortableTest,
	#superclass : #TestCase,
	#instVars : [
		'series'
	],
	#category : #'DataFrame-Tests'
}

{ #category : #tests }
DataSeriesSortableTest >> setUp [

	series := #(3 2 4 5 1 3 2 5 5 2 1) asDataSeries.
	series keys: #(a b c d e f g h i j k).
	series name: #TestSeries.
]

{ #category : #tests }
DataSeriesSortableTest >> testIsSorted [

	| sorted notSorted |
	
	sorted := #(1 2 3 5 5) asDataSeries.
	notSorted := #(3 2 5 1 5) asDataSeries.
	
	self assert: sorted isSorted.
	self assert: notSorted isSorted not.
]

{ #category : #tests }
DataSeriesSortableTest >> testIsSortedBy [

	| sortBlock sorted notSorted1 notSorted2 |
	
	sortBlock := [ :a :b | a > b ].
	
	sorted := #(5 4 3 2 1) asDataSeries.
	notSorted1 := #(5 5 3 2 1) asDataSeries.
	notSorted2 := #(3 2 5 1 5) asDataSeries.
	
	self assert: (sorted isSortedBy: sortBlock).
	self assert: (notSorted1 isSortedBy: sortBlock) not.
	self assert: (notSorted2 isSortedBy: sortBlock) not.
]

{ #category : #tests }
DataSeriesSortableTest >> testSort [
"Should sort this series into ascending order using the '<=' operator. Keys should be reordered together with elements"

	| expected |
	
	series sort.
	
	expected := #(1 1 2 2 2 3 3 4 5 5 5) asDataSeries.
	expected keys: #(e k b g j a f c d h i).
	expected name: series name.
	
	self assert: series equals: expected.
]

{ #category : #tests }
DataSeriesSortableTest >> testSortBy [
"Should sort this series using the given sortBlock. Keys should be reordered together with elements"

	| expected |
	
	series sort: [ :a :b | a >= b ].
	
	expected := #(5 5 5 4 3 3 2 2 2 1 1) asDataSeries.
	expected keys: #(d h i c a f b g j e k).
	expected name: series name.
	
	self assert: series equals: expected.
]

{ #category : #tests }
DataSeriesSortableTest >> testSorted [
"Should return a new series which contains the same elements as self but its elements are sorted in ascending order using the #'<=' operator. Keys should be reordered together with elements. The initial series should not be affected"

	| actual expected |
	
	actual := series sorted.
	
	expected := #(1 1 2 2 2 3 3 4 5 5 5) asDataSeries.
	expected keys: #(e k b g j a f c d h i).
	expected name: series name.
	
	self assert: actual equals: expected.
	self assert: series isSorted not.
]

{ #category : #tests }
DataSeriesSortableTest >> testSortedBy [
"Should return a new series which contains the same elements as self but its elements are sorted using the given sortBlock. Keys should be reordered together with elements. The initial series should not be affected"

	| sortBlock actual expected |
	
	sortBlock := [ :a :b | a >= b ].
	actual := series sorted: sortBlock.
	
	expected := #(5 5 5 4 3 3 2 2 2 1 1) asDataSeries.
	expected keys: #(d h i c a f b g j e k).
	expected name: series name.
	
	self assert: actual equals: expected.
	self assert: (series isSortedBy: sortBlock) not.
]
