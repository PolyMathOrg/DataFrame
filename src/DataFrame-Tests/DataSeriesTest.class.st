Class {
	#name : #DataSeriesTest,
	#superclass : #TestCase,
	#instVars : [
		'series',
		'keyArray'
	],
	#category : #'DataFrame-Tests'
}

{ #category : #initialization }
DataSeriesTest >> setUp [

	series := (10 to: 100 by: 10) asDataSeries.
	keyArray := #(a b c d e f g h i j).
	
	series keys: keyArray.
	series name: 'ExampleSeries'.
]

{ #category : #tests }
DataSeriesTest >> testAsDictionary [
	| expected actual |
	
	expected := {
		'a' -> 10 . 'b' -> 20 . 'c' -> 30 . 'd' -> 40 .
		'e' -> 50 . 'f' -> 60 . 'g' -> 70 . 'h' -> 80 .
		'i' -> 90 . 'j' -> 100 } asDictionary.
	
	actual := series asDictionary.
	self assert: actual equals: expected
]

{ #category : #tests }
DataSeriesTest >> testAt [

	self assert: (series at: #b) equals: 20.
]

{ #category : #tests }
DataSeriesTest >> testAtIndex [

	self assert: (series atIndex: 2) equals: 20.
]

{ #category : #tests }
DataSeriesTest >> testAtIndexIfAbsent [

	self assert: (series atIndex: 2 ifAbsent: [ 'Executing a block' ]) equals: 20.
	self assert: (series atIndex: 100 ifAbsent: [ 'Executing a block' ])
		equals: 'Executing a block'.
]

{ #category : #tests }
DataSeriesTest >> testAtIndexPut [

	| expected |
	
	series atIndex: 6 put: -2.	
	expected := #(10 20 30 40 50 -2 70 80 90 100) asDataSeries.
	expected keys: keyArray.
	expected name: series name.
	
	self assert: series equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testAtPut [

	| expected |
	
	series at: #f put: -2.	
	expected := #(10 20 30 40 50 -2 70 80 90 100) asDataSeries.
	expected keys: keyArray.
	expected name: series name.
	
	self assert: series equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testAtPutNewElement [

	| expected |
	
	series at: #X put: -2.	
	expected := #(10 20 30 40 50 60 70 80 90 100 -2) asDataSeries.
	expected keys: (keyArray copyWith: #X).
	expected name: series name.
	
	self assert: series equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testCollect [

	| actual expected |
	
	actual := series collect: [ :each |
		each / 10 ].
	
	expected := (1 to: 10) asDataSeries.
	expected keys: keyArray.
	expected name: series name.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testCopy [

	| seriesCopy expectedOriginal expectedCopy |
	
	expectedOriginal := #(10 20 30 40 50 60 70 80 90 100) asDataSeries.
	expectedOriginal keys: keyArray.
	expectedOriginal name: series name.
		
	expectedCopy := #(10 20 30 40 50 -2 70 80 100 -3) asDataSeries.
	expectedCopy keys: ((keyArray copyWithout: #i) copyWith: #X).
	expectedCopy name: #ChangedName.
	
	seriesCopy := series copy.
	seriesCopy at: 6 put: -2.
	seriesCopy removeAt: #i.
	seriesCopy at: #X put: -3.
	seriesCopy name: #ChangedName.
	
	self assert: series equals: expectedOriginal.
	self assert: seriesCopy equals: expectedCopy.
]

{ #category : #tests }
DataSeriesTest >> testCreateDataSeriesAsDataSeries [

	| dataSeries |
	dataSeries := #(a b c) asDataSeries.
	
	self assert: dataSeries size equals: 3.
	self assert: dataSeries asArray equals: #(a b c).
	self assert: dataSeries keys equals: #(1 2 3).
	self assert: dataSeries name isNil.
]

{ #category : #tests }
DataSeriesTest >> testCreateDataSeriesWithKeysValues [

	| values keys dataSeries |
	
	values := #(a b c).
	keys := #(x y z).
	
	dataSeries := DataSeries
		withKeys: keys
		values: values.
	
	self assert: dataSeries size equals: 3.
	self assert: dataSeries asArray equals: values.
	self assert: dataSeries keys equals: keys.
	self assert: dataSeries name isNil.
]

{ #category : #tests }
DataSeriesTest >> testCreateDataSeriesWithKeysValuesName [

	| values keys name dataSeries |
	
	values := #(a b c).
	keys := #(x y z).
	name := 'Some data'.
	
	dataSeries := DataSeries
		withKeys: keys
		values: values
		name: name.
	
	self assert: dataSeries size equals: 3.
	self assert: dataSeries asArray equals: values.
	self assert: dataSeries keys equals: keys.
	self assert: dataSeries name equals: name.
]

{ #category : #tests }
DataSeriesTest >> testCreateDataSeriesWithValues [

	| values dataSeries |
	
	values := #(a b c).
	dataSeries := DataSeries withValues: values.
	
	self assert: dataSeries size equals: 3.
	self assert: dataSeries asArray equals: values.
	self assert: dataSeries keys equals: #(1 2 3).
	self assert: dataSeries name isNil.
]

{ #category : #tests }
DataSeriesTest >> testCreateDataSeriesWithValuesName [

	| values name dataSeries |
	
	values := #(a b c).
	name := 'Some data'.
	
	dataSeries := DataSeries
		withValues: values
		name: name.
	
	self assert: dataSeries size equals: 3.
	self assert: dataSeries asArray equals: values.
	self assert: dataSeries keys equals: #(1 2 3).
	self assert: dataSeries name equals: name.
]

{ #category : #tests }
DataSeriesTest >> testCreateEmptyDataSeries [

	| dataSeries |
	dataSeries := DataSeries new.
	
	self assert: dataSeries size equals: 0.
	self assert: dataSeries asArray equals: #().
	self assert: dataSeries keys equals: #().
	self assert: dataSeries name isNil.
]

{ #category : #tests }
DataSeriesTest >> testCreateEmptyDataSeriesWithKeys [

	| keys dataSeries |
	
	keys := #(x y z) asOrderedCollection.
	dataSeries := DataSeries withKeys: keys.
	
	self assert: dataSeries size equals: 3.
	self assert: dataSeries asArray equals: #(nil nil nil).
	self assert: dataSeries keys equals: keys.
	self assert: dataSeries name isNil.
]

{ #category : #tests }
DataSeriesTest >> testCreateEmptyDataSeriesWithKeysName [

	| keys name dataSeries |
	
	keys := #(x y z) asOrderedCollection.
	name := 'Some data'.
	dataSeries := DataSeries withKeys: keys name: name.
	
	self assert: dataSeries size equals: 3.
	self assert: dataSeries asArray equals: #(nil nil nil).
	self assert: dataSeries keys equals: keys.
	self assert: dataSeries name equals: name.
]

{ #category : #tests }
DataSeriesTest >> testCreateEmptyDataSeriesWithName [

	| name dataSeries |
	
	name := 'Some data'.
	dataSeries := DataSeries withName: name.
	
	self assert: dataSeries size equals: 0.
	self assert: dataSeries asArray equals: #().
	self assert: dataSeries keys equals: #() asOrderedCollection.
	self assert: dataSeries name equals: name.
]

{ #category : #tests }
DataSeriesTest >> testCrossTabulateWith [

	| series1 series2 expected |
	series1 := #(A B C A A B C A B B) asDataSeries.
	series2 := #(1 2 1 2 1 1 2 1 2 2) asDataSeries.
	
	expected := DataFrame withRows:
		#((3 1)(1 3)(1 1)).
		
	expected rowNames: #(A B C).
	expected columnNames: #(1 2).
	
	self assert: (series1 crossTabulateWith: series2) equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testDo [

	| sum |
	sum := 0.
	
	series do: [ :each |
		sum := sum + each ].
	
	self assert: sum equals: 550.
]

{ #category : #tests }
DataSeriesTest >> testEquality [

	| a b |
	
	a := #(1 0.1 'a') asDataSeries.
	b := #(1 0.1 'a') asDataSeries.
	
	a name: 'A'.
	b name: 'B'.
	
	self assert: a equals: b.
]

{ #category : #tests }
DataSeriesTest >> testFrequencyTable [

	| aSeries expected |
	aSeries := #(A B C A A B C A B B) asDataSeries.
	
	expected := DataFrame withColumns: {
		{ 4 . 4 . 2 } .
		{ 2/5 . 2/5 . 1/5 }}.
		
	expected rowNames: #(A B C).
	expected columnNames: #(Count Proportion).
	
	self assert: aSeries frequencyTable equals: expected
]

{ #category : #tests }
DataSeriesTest >> testInequality [

	| a b |
	
	a := #(1 0.1 'a') asDataSeries.
	b := #(2 0.2 'b') asDataSeries.
	
	a name: 'A'.
	b name: 'B'.
	
	self assert: (a ~= b).
]

{ #category : #tests }
DataSeriesTest >> testRemoveAt [

	| expected |
	
	expected := #(10 20 40 50 60 70 80 90 100) asDataSeries.
	expected keys: (keyArray copyWithout: #c).
	expected name: series name.
	
	series removeAt: #c.
	
	self assert: series equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testRemoveAtIndex [

	| expected |
	
	expected := #(10 20 40 50 60 70 80 90 100) asDataSeries.
	expected keys: (keyArray copyWithout: #c).
	expected name: series name.
	
	series removeAtIndex: 3.
	
	self assert: series equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testReplaceFromToWithArray [

	| replacement expected |
	
	replacement := #(x y z).
	
	expected := #(10 20 x y z 60 70 80 90 100) asDataSeries.
	expected keys: keyArray.
	expected name: series name.
	
	series replaceFrom: 3 to: 5 with: replacement.
	
	self assert: series equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testReplaceFromToWithSeries [

	| replacement expected |
	
	replacement := #(x y z) asDataSeries.
	replacement keys: #(k1 k2 k3).
	replacement name: #Replacement.
	
	expected := #(10 20 x y z 60 70 80 90 100) asDataSeries.
	expected keys: #(a b k1 k2 k3 f g h i j).
	expected name: series name.
	
	series replaceFrom: 3 to: 5 with: replacement.
	
	self assert: series equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testReplaceFromToWithStartingAtArray [

	| replacement expected |
	
	replacement := #(a b c d e).
	
	expected := #(10 20 b c d 60 70 80 90 100) asDataSeries.
	expected keys: keyArray.
	expected name: series name.
	
	series replaceFrom: 3 to: 5 with: replacement startingAt: 2.
	
	self assert: series equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testReplaceFromToWithStartingAtSeries [

	| replacement expected |
	
	replacement := #(a b c d e) asDataSeries.
	replacement keys: #(k1 k2 k3 k4 k5).
	replacement name: #Replacement.
	
	expected := #(10 20 b c d 60 70 80 90 100) asDataSeries.
	expected keys: #(a b k2 k3 k4 f g h i j).
	expected name: series name.
	
	series replaceFrom: 3 to: 5 with: replacement startingAt: 2.
	
	self assert: series equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testSort [
	| cities expected |
	
	cities := #(London Dubai Paris Berlin) asDataSeries.
	cities keys: #(A B C D).
	cities name: #Cities.
	
	expected := #(Berlin Dubai London Paris) asDataSeries.
	expected keys: #(D B A C).
	expected name: #Cities.
	
	cities sort.
	self assert: cities equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testSortBlock [
	| cities expected |
	
	cities := #(London Dubai Paris Berlin) asDataSeries.
	cities keys: #(A B C D).
	cities name: #Cities.
	
	expected := #(Dubai London Berlin Paris) asDataSeries.
	expected keys: #(B A D C).
	expected name: #Cities.
	
	cities sort: [ :a :b | a value last <= b value last ].
	self assert: cities equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testSortDescending [
	| cities expected |
	
	cities := #(London Dubai Paris Berlin) asDataSeries.
	cities keys: #(A B C D).
	cities name: #Cities.
	
	expected := #(Paris London Dubai Berlin) asDataSeries.
	expected keys: #(C A B D).
	expected name: #Cities.
	
	cities sortDescending.
	self assert: cities equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testWithIndexCollect [

	| actual expected |
	
	actual := series withIndexCollect: [ :each :i |
		each / 10 + i ].
	
	expected := (2 to: 20 by: 2) asDataSeries.
	expected keys: keyArray.
	expected name: series name.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testWithIndexDo [

	| sum |
	sum := 0.
	
	series withIndexDo: [ :each :i |
		sum := sum + (each / i) ].
	
	self assert: sum equals: 100.
]

{ #category : #tests }
DataSeriesTest >> testWithKeyCollect [

	| actual expected |
	
	actual := series withKeyCollect: [ :each :key |
		each / 10 + (keyArray indexOf: key) ].
	
	expected := (2 to: 20 by: 2) asDataSeries.
	expected keys: keyArray.
	expected name: series name.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testWithKeyDo [

	| sum |
	sum := 0.
	
	series withKeyDo: [ :each :key |
		sum := sum + (each / (keyArray indexOf: key)) ].
	
	self assert: sum equals: 100.
]
