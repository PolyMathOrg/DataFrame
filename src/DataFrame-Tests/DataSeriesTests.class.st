Class {
	#name : #DataSeriesTests,
	#superclass : #TestCase,
	#instVars : [
		'series',
		'keyArray'
	],
	#category : 'DataFrame-Tests'
}

{ #category : #initialization }
DataSeriesTests >> setUp [

	series := (10 to: 100 by: 10) asDataSeries.
	keyArray := #(a b c d e f g h i j).
	
	series keys: keyArray.
	series name: 'ExampleSeries'.
]

{ #category : #tests }
DataSeriesTests >> testAddAtKey [

	| expected |
	
	series add: -2 atKey: #X.	
	expected := #(10 20 30 40 50 60 70 80 90 100 -2) asDataSeries.
	expected keys: (keyArray copyWith: #X).
	expected name: series name.
	
	self assert: series equals: expected.
]

{ #category : #tests }
DataSeriesTests >> testAsDataSeries [

	| aSeries |
	aSeries := #(a b c) asDataSeries.
	
	self assert: aSeries size equals: 3.
	self assert: aSeries asArray equals: #(a b c).
	self assert: aSeries keys equals: #(1 2 3).
]

{ #category : #tests }
DataSeriesTests >> testAsStringTable [

	| population expected actual |
	population := #(1.609 2.789 8.788) asDataSeries.
	population keys: #(Barcelona Dubai London).
	population name: #Population.
	
	expected := String new writeStream.
	expected
		nextPutAll: '           |  Population  '; cr;
		nextPutAll: '-----------+--------------'; cr;
		nextPutAll: 'Barcelona  |       1.609  '; cr;
    	nextPutAll: '    Dubai  |       2.789  '; cr;
		nextPutAll: '   London  |       8.788  '; cr.
	
	expected := expected contents.
	actual := population asStringTable.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSeriesTests >> testAt [

	self assert: (series at: 2) equals: 20.
]

{ #category : #tests }
DataSeriesTests >> testAtIfAbsent [

	self assert: (series at: 2) equals: 20.
	
	self assert: (series at: 100 ifAbsent: [ 'Executing a block' ])
		equals: 'Executing a block'.
]

{ #category : #tests }
DataSeriesTests >> testAtKeyPut [

	| expected |
	
	series atKey: #f put: -2.	
	expected := #(10 20 30 40 50 -2 70 80 90 100) asDataSeries.
	expected keys: keyArray.
	expected name: series name.
	
	self assert: series equals: expected.
]

{ #category : #tests }
DataSeriesTests >> testAtKeyPutNewElement [

	| expected |
	
	series atKey: #X put: -2.	
	expected := #(10 20 30 40 50 60 70 80 90 100 -2) asDataSeries.
	expected keys: (keyArray copyWith: #X).
	expected name: series name.
	
	self assert: series equals: expected.
]

{ #category : #tests }
DataSeriesTests >> testAtPut [

	| expected |
	
	series at: 6 put: -2.	
	expected := #(10 20 30 40 50 -2 70 80 90 100) asDataSeries.
	expected keys: keyArray.
	expected name: series name.
	
	self assert: series equals: expected.
]

{ #category : #tests }
DataSeriesTests >> testCollect [

	| actual expected |
	
	actual := series collect: [ :each |
		each / 10 ].
	
	expected := (1 to: 10) asDataSeries.
	expected keys: keyArray.
	expected name: series name.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSeriesTests >> testCopy [

	| seriesCopy expectedOriginal expectedCopy |
	
	expectedOriginal := #(10 20 30 40 50 60 70 80 90 100) asDataSeries.
	expectedOriginal keys: keyArray.
	expectedOriginal name: series name.
		
	expectedCopy := #(10 20 30 40 50 -2 70 80 100 -3) asDataSeries.
	expectedCopy keys: ((keyArray copyWithout: #i) copyWith: #X).
	expectedCopy name: #ChangedName.
	
	seriesCopy := series copy.
	seriesCopy at: 6 put: -2.
	seriesCopy removeAtKey: #i.
	seriesCopy add: -3 atKey: #X.
	seriesCopy name: #ChangedName.
	
	self assert: series equals: expectedOriginal.
	self assert: seriesCopy equals: expectedCopy.
]

{ #category : #tests }
DataSeriesTests >> testCrossTabulateWith [

	| series1 series2 expected |
	series1 := #(A B C A A B C A B B) asDataSeries.
	series2 := #(1 2 1 2 1 1 2 1 2 2) asDataSeries.
	
	expected := DataFrame fromRows:
		#((3 1)(1 3)(1 1)).
		
	expected rowNames: #(A B C).
	expected columnNames: #(1 2).
	
	self assert: (series1 crossTabulateWith: series2) equals: expected.
]

{ #category : #tests }
DataSeriesTests >> testDo [

	| sum |
	sum := 0.
	
	series do: [ :each |
		sum := sum + each ].
	
	self assert: sum equals: 550.
]

{ #category : #tests }
DataSeriesTests >> testDoWithIndex [

	| sum |
	sum := 0.
	
	series doWithIndex: [ :each :i |
		sum := sum + (each / i) ].
	
	self assert: sum equals: 100.
]

{ #category : #tests }
DataSeriesTests >> testEquality [

	| a b |
	
	a := #(1 0.1 'a') asDataSeries.
	b := #(1 0.1 'a') asDataSeries.
	
	a name: 'A'.
	b name: 'B'.
	
	self assert: a equals: b.
]

{ #category : #tests }
DataSeriesTests >> testFrequencyTable [

	| aSeries expected |
	aSeries := #(A B C A A B C A B B) asDataSeries.
	
	expected := DataFrame fromColumns: {
		{ 4 . 4 . 2 } .
		{ 2/5 . 2/5 . 1/5 }}.
		
	expected rowNames: #(A B C).
	expected columnNames: #(Count Proportion).
	
	self assert: aSeries frequencyTable equals: expected
]

{ #category : #tests }
DataSeriesTests >> testInequality [

	| a b |
	
	a := #(1 0.1 'a') asDataSeries.
	b := #(2 0.2 'b') asDataSeries.
	
	a name: 'A'.
	b name: 'B'.
	
	self assert: (a ~= b).
]

{ #category : #tests }
DataSeriesTests >> testIsCategorical [

	| quantitative categorical |
	
	quantitative := #(1.609 2.789 8.788) asDataSeries.
	categorical := #(Male Female) asDataSeries.
	
	self assert: quantitative isCategorical not.
	self assert: categorical isCategorical.
]

{ #category : #tests }
DataSeriesTests >> testIsQuantitative [

	| quantitative categorical |
	
	quantitative := #(1.609 2.789 8.788) asDataSeries.
	categorical := #(Male Female) asDataSeries.
	
	self assert: quantitative isQuantitative.
	self assert: categorical isQuantitative not.
]

{ #category : #tests }
DataSeriesTests >> testPrintOn [

	| population expected actual |
	population := #(1.609 2.789 8.788) asDataSeries.
	population keys: #(Barcelona Dubai London).
	population name: #Population.
	
	expected := 'a DataSeries [3 items]: ', 1.609 class name.
	
	actual := String new writeStream.
	population printOn: actual.
	actual := actual contents.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSeriesTests >> testRemoveAt [

	| expected |
	
	expected := #(10 20 40 50 60 70 80 90 100) asDataSeries.
	expected keys: (keyArray copyWithout: #c).
	expected name: series name.
	
	series removeAt: 3.
	
	self assert: series equals: expected.
]

{ #category : #tests }
DataSeriesTests >> testRemoveAtKey [

	| expected |
	
	expected := #(10 20 40 50 60 70 80 90 100) asDataSeries.
	expected keys: (keyArray copyWithout: #c).
	expected name: series name.
	
	series removeAtKey: #c.
	
	self assert: series equals: expected.
]

{ #category : #tests }
DataSeriesTests >> testReplaceFromToWithArray [

	| replacement expected |
	
	replacement := #(x y z).
	
	expected := #(10 20 x y z 60 70 80 90 100) asDataSeries.
	expected keys: keyArray.
	expected name: series name.
	
	series replaceFrom: 3 to: 5 with: replacement.
	
	self assert: series equals: expected.
]

{ #category : #tests }
DataSeriesTests >> testReplaceFromToWithSeries [

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
DataSeriesTests >> testReplaceFromToWithStartingAtArray [

	| replacement expected |
	
	replacement := #(a b c d e).
	
	expected := #(10 20 b c d 60 70 80 90 100) asDataSeries.
	expected keys: keyArray.
	expected name: series name.
	
	series replaceFrom: 3 to: 5 with: replacement startingAt: 2.
	
	self assert: series equals: expected.
]

{ #category : #tests }
DataSeriesTests >> testReplaceFromToWithStartingAtSeries [

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
DataSeriesTests >> testVarSizeInstanceCreation [

	| aSeries |
	aSeries := DataSeries new: 10.
	self assert: aSeries size equals: 10.
]

{ #category : #tests }
DataSeriesTests >> testWithIndexCollect [

	| actual expected |
	
	actual := series collectWithIndex: [ :each :i |
		each / 10 + i ].
	
	expected := (2 to: 20 by: 2) asDataSeries.
	expected name: series name.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSeriesTests >> testWithKeyDo [

	| sum |
	sum := 0.
	
	series withKeyDo: [ :each :key |
		sum := sum + (each / (keyArray indexOf: key)) ].
	
	self assert: sum equals: 100.
]
