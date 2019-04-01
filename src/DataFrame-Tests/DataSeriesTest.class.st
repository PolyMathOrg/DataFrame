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
	keyArray := #(a b c d e f g h i j k).
	
	series := DataSeries
		withKeys: keyArray
		values: #(3 7 6 20 8 9 8 10 15 13 16)
		name: 'ExampleSeries'.
]

{ #category : #tests }
DataSeriesTest >> testArithmeticsAddArrayToSeries [
	| series array actual expected |
	
	series := DataSeries withKeys: #(a b c) values: #(1 2 3) name: #X.
	array := #(3 4 5).
	
	expected := DataSeries withKeys: #(a b c) values: #(4 6 8) name: #X.
	actual := series + array.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testArithmeticsAddScalarToSeries [
	| series scalar actual expected |
	
	series := DataSeries withKeys: #(a b c) values: #(1 2 3) name: #X.
	scalar := 10.
	
	expected := DataSeries withKeys: #(a b c) values: #(11 12 13) name: #X.
	actual := series + scalar.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testArithmeticsAddSeriesToArray [
	| array series actual expected |
	
	array := #(1 2 3).
	series := DataSeries withKeys: #(a b c) values: #(3 4 5) name: #X.
	
	expected := DataSeries withKeys: #(a b c) values: #(4 6 8) name: #X.
	actual := array + series.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testArithmeticsAddSeriesToScalar [
	| scalar series actual expected |
	
	scalar := 10.
	series := DataSeries withKeys: #(a b c) values: #(3 4 5) name: #X.
	
	expected := DataSeries withKeys: #(a b c) values: #(13 14 15) name: #X.
	actual := scalar + series.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testArithmeticsAddSeriesToSeriesDifferentKeys [
	| firstSeries secondSeries |
	
	firstSeries := DataSeries withKeys: #(x y z) values: #(1 2 3) name: #X.
	secondSeries := DataSeries withKeys: #(a b c) values: #(3 4 5) name: #X.
	
	self should: [ firstSeries + secondSeries ] raise: Error.
]

{ #category : #tests }
DataSeriesTest >> testArithmeticsAddSeriesToSeriesSameKeysAndName [
	| firstSeries secondSeries actual expected |
	
	firstSeries := DataSeries withKeys: #(a b c) values: #(1 2 3) name: #X.
	secondSeries := DataSeries withKeys: #(a b c) values: #(3 4 5) name: #X.
	
	expected := DataSeries withKeys: #(a b c) values: #(4 6 8) name: #X.
	actual := firstSeries + secondSeries.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testArithmeticsAddSeriesToSeriesSameKeysDifferentName [
	| firstSeries secondSeries actual expected |
	
	firstSeries := DataSeries withKeys: #(a b c) values: #(1 2 3) name: #X.
	secondSeries := DataSeries withKeys: #(a b c) values: #(3 4 5) name: #Y.
	
	expected := DataSeries withKeys: #(a b c) values: #(4 6 8) name: '(no name)'.
	actual := firstSeries + secondSeries.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testArithmeticsDivideArrayBySeries [

	| array a b |
	
	array := #(2 4 3).
	a := #(1 2 3) asDataSeries.
	b := { 2 . 2 . 1 } asDataSeries.
	
	self assert: array / a equals: b.
]

{ #category : #tests }
DataSeriesTest >> testArithmeticsDivideSeriesByArray [

	| array a b |
	
	array := #(2 4 3).
	a := #(1 2 3) asDataSeries.
	b := { 1/2 . 1/2 . 1 } asDataSeries.
	
	self assert: a / array equals: b.
]

{ #category : #tests }
DataSeriesTest >> testArithmeticsDivideSeriesByScalar [

	| a b |
	
	a := #(1 2 3) asDataSeries.
	b := #(0.5 1 1.5) asDataSeries.
	
	self assert: a / 2 equals: b.
]

{ #category : #tests }
DataSeriesTest >> testArithmeticsDivideSeriesBySeries [

	| a b c |
	
	a := #(2 4 3) asDataSeries.
	b := #(1 2 3) asDataSeries.
	c := { 2 . 2 . 1 } asDataSeries.
	
	self assert: a / b equals: c.
]

{ #category : #tests }
DataSeriesTest >> testArithmeticsDivideSeriesBySeriesDifferentKeys [
	| firstSeries secondSeries |
	
	firstSeries := DataSeries withKeys: #(x y z) values: #(1 2 3) name: #X.
	secondSeries := DataSeries withKeys: #(a b c) values: #(3 4 5) name: #X.
	
	self should: [ firstSeries / secondSeries ] raise: Error.
]

{ #category : #tests }
DataSeriesTest >> testArithmeticsDivideSeriesBySeriesSameKeysAndName [
	| firstSeries secondSeries actual expected |
	
	firstSeries := DataSeries withKeys: #(a b c) values: #(1 2 3) name: #X.
	secondSeries := DataSeries withKeys: #(a b c) values: #(3 4 5) name: #X.
	
	expected := DataSeries withKeys: #(a b c) values: { 1/3 . 1/2 . 3/5 } name: #X.
	actual := firstSeries / secondSeries.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testArithmeticsDivideSeriesBySeriesSameKeysDifferentName [
	| firstSeries secondSeries actual expected |
	
	firstSeries := DataSeries withKeys: #(a b c) values: #(1 2 3) name: #X.
	secondSeries := DataSeries withKeys: #(a b c) values: #(3 4 5) name: #Y.
	
	expected := DataSeries withKeys: #(a b c) values: { 1/3 . 1/2 . 3/5 } name: '(no name)'.
	actual := firstSeries / secondSeries.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testArithmeticsMultiplyArrayBySeries [

	| array a b |
	
	array := #(2 4 3).
	a := #(1 2 3) asDataSeries.
	b := #(2 8 9) asDataSeries.
	
	self assert: array * a equals: b.
]

{ #category : #tests }
DataSeriesTest >> testArithmeticsMultiplyScalarBySeries [

	| a b |
	
	a := #(1 2 3) asDataSeries.
	b := #(2 4 6) asDataSeries.
	
	self assert: 2 * a equals: b.
]

{ #category : #tests }
DataSeriesTest >> testArithmeticsMultiplySeriesByArray [

	| array a b |
	
	array := #(2 4 3).
	a := #(1 2 3) asDataSeries.
	b := #(2 8 9) asDataSeries.
	
	self assert: a * array equals: b.
]

{ #category : #tests }
DataSeriesTest >> testArithmeticsMultiplySeriesByScalar [

	| a b |
	
	a := #(1 2 3) asDataSeries.
	b := #(2 4 6) asDataSeries.
	
	self assert: a * 2 equals: b.
]

{ #category : #tests }
DataSeriesTest >> testArithmeticsMultiplySeriesBySeries [

	| a b c |
	
	a := #(2 4 3) asDataSeries.
	b := #(1 2 3) asDataSeries.
	c := #(2 8 9) asDataSeries.
	
	self assert: a * b equals: c.
]

{ #category : #tests }
DataSeriesTest >> testArithmeticsMultiplySeriesBySeriesDifferentKeys [
	| firstSeries secondSeries |
	
	firstSeries := DataSeries withKeys: #(x y z) values: #(1 2 3) name: #X.
	secondSeries := DataSeries withKeys: #(a b c) values: #(3 4 5) name: #X.
	
	self should: [ firstSeries * secondSeries ] raise: Error.
]

{ #category : #tests }
DataSeriesTest >> testArithmeticsMultiplySeriesBySeriesSameKeysAndName [
	| firstSeries secondSeries actual expected |
	
	firstSeries := DataSeries withKeys: #(a b c) values: #(1 2 3) name: #X.
	secondSeries := DataSeries withKeys: #(a b c) values: #(3 4 5) name: #X.
	
	expected := DataSeries withKeys: #(a b c) values: #(3 8 15) name: #X.
	actual := firstSeries * secondSeries.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testArithmeticsMultiplySeriesBySeriesSameKeysDifferentName [
	| firstSeries secondSeries actual expected |
	
	firstSeries := DataSeries withKeys: #(a b c) values: #(1 2 3) name: #X.
	secondSeries := DataSeries withKeys: #(a b c) values: #(3 4 5) name: #Y.
	
	expected := DataSeries withKeys: #(a b c) values: #(3 8 15) name: '(no name)'.
	actual := firstSeries * secondSeries.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testArithmeticsSubtractArrayFromSeries [

	| array a b |
	
	array := #(2 4 3).
	a := #(1 2 3) asDataSeries.
	b := #(-1 -2 0) asDataSeries.
	
	self assert: a - array equals: b.
]

{ #category : #tests }
DataSeriesTest >> testArithmeticsSubtractScalarFromSeries [

	| a b |
	
	a := #(1 2 3) asDataSeries.
	b := #(-1 0 1) asDataSeries.
	
	self assert: a - 2 equals: b.
]

{ #category : #tests }
DataSeriesTest >> testArithmeticsSubtractSeriesFromArray [

	| array a b |
	
	array := #(2 4 3).
	a := #(1 2 3) asDataSeries.
	b := #(1 2 0) asDataSeries.
	
	self assert: array - a equals: b.
]

{ #category : #tests }
DataSeriesTest >> testArithmeticsSubtractSeriesFromScalar [

	| a b |
	
	a := #(1 2 3) asDataSeries.
	b := #(1 0 -1) asDataSeries.
	
	self assert: 2 - a equals: b.
]

{ #category : #tests }
DataSeriesTest >> testArithmeticsSubtractSeriesFromSeries [

	| a b c |
	
	a := #(2 4 3) asDataSeries.
	b := #(1 2 3) asDataSeries.
	c := #(1 2 0) asDataSeries.
	
	self assert: a - b equals: c.
]

{ #category : #tests }
DataSeriesTest >> testArithmeticsSubtractSeriesFromSeriesDifferentKeys [
	| firstSeries secondSeries |
	
	firstSeries := DataSeries withKeys: #(x y z) values: #(1 2 3) name: #X.
	secondSeries := DataSeries withKeys: #(a b c) values: #(3 4 5) name: #X.
	
	self should: [ firstSeries - secondSeries ] raise: Error.
]

{ #category : #tests }
DataSeriesTest >> testArithmeticsSubtractSeriesFromSeriesSameKeysAndName [
	| firstSeries secondSeries actual expected |
	
	firstSeries := DataSeries withKeys: #(a b c) values: #(1 2 3) name: #X.
	secondSeries := DataSeries withKeys: #(a b c) values: #(3 4 5) name: #X.
	
	expected := DataSeries withKeys: #(a b c) values: #(-2 -2 -2) name: #X.
	actual := firstSeries - secondSeries.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testArithmeticsSubtractSeriesFromSeriesSameKeysDifferentName [
	| firstSeries secondSeries actual expected |
	
	firstSeries := DataSeries withKeys: #(a b c) values: #(1 2 3) name: #X.
	secondSeries := DataSeries withKeys: #(a b c) values: #(3 4 5) name: #Y.
	
	expected := DataSeries withKeys: #(a b c) values: #(-2 -2 -2) name: '(no name)'.
	actual := firstSeries - secondSeries.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testAsDictionary [
	| expected actual |
	
	expected := {
		'a' -> 3 . 'b' -> 7 . 'c' -> 6 . 'd' -> 20 .
		'e' -> 8 . 'f' -> 9 . 'g' -> 8 . 'h' -> 10 .
		'i' -> 15 . 'j' -> 13 . 'k' -> 16 } asDictionary.
	
	actual := series asDictionary.
	self assert: actual equals: expected
]

{ #category : #tests }
DataSeriesTest >> testAt [

	self assert: (series at: #b) equals: 7.
]

{ #category : #tests }
DataSeriesTest >> testAtIndex [

	self assert: (series atIndex: 2) equals: 7.
]

{ #category : #tests }
DataSeriesTest >> testAtIndexPut [

	| expected |
	
	series atIndex: 6 put: -2.
	
	expected := DataSeries
		withKeys: keyArray
		values: #(3 7 6 20 8 -2 8 10 15 13 16)
		name: series name.
	
	self assert: series equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testAtIndexTransform [

	| expected |
	
	series atIndex: 6 transform: [ :x | x + 1 ].	
	
	expected := DataSeries
		withKeys: keyArray
		values: #(3 7 6 20 8 10 8 10 15 13 16)
		name: series name.
	
	self assert: series equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testAtPut [

	| expected |
	
	series at: #f put: -2.	
	
	expected := DataSeries
		withKeys: keyArray
		values: #(3 7 6 20 8 -2 8 10 15 13 16)
		name: series name.
	
	self assert: series equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testAtPutNewElement [

	| expected |
	
	series at: #X put: -2.	
	
	expected := DataSeries
		withKeys: (keyArray copyWith: #X)
		values: #(3 7 6 20 8 9 8 10 15 13 16 -2)
		name: series name.
	
	self assert: series equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testAtTransform [

	| expected |
	
	series at: #f transform: [ :x | x + 1 ].	
	
	expected := DataSeries
		withKeys: keyArray
		values: #(3 7 6 20 8 10 8 10 15 13 16)
		name: series name.
	
	self assert: series equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testAtTransformIfAbsent [

	| expected exceptionBlockEvaluated |
	
	exceptionBlockEvaluated := false.
	series
		at: #NoSuchKey
		transform: [ :x | x + 1 ]
		ifAbsent: [ exceptionBlockEvaluated := true ].	
	
	expected := DataSeries
		withKeys: keyArray
		values: #(3 7 6 20 8 9 8 10 15 13 16)
		name: series name.
	
	self assert: series equals: expected.
	self assert: exceptionBlockEvaluated.
]

{ #category : #tests }
DataSeriesTest >> testAverage [

	self assert: series average equals: (115/11).
]

{ #category : #tests }
DataSeriesTest >> testCloseTo [

	| firstSeries secondSeries |
	
	firstSeries := DataSeries withKeys: #(a b c) values: #(1 0.1 2) name: 'A'.
	secondSeries := DataSeries withKeys: #(a b c) values: #(1 0.10000001 2) name: 'A'.
	
	self assert: firstSeries closeTo: secondSeries.
]

{ #category : #tests }
DataSeriesTest >> testCloseToDifferentKeys [

	| firstSeries secondSeries |
	
	firstSeries := DataSeries withKeys: #(a b c) values: #(1 0.1 2) name: 'A'.
	secondSeries := DataSeries withKeys: #(x y z) values: #(1 0.10000001 2) name: 'A'.
	
	self deny: (firstSeries closeTo: secondSeries).
]

{ #category : #tests }
DataSeriesTest >> testCloseToDifferentNames [

	| firstSeries secondSeries |
	
	firstSeries := DataSeries withKeys: #(a b c) values: #(1 0.1 2) name: 'A'.
	secondSeries := DataSeries withKeys: #(a b c) values: #(1 0.10000001 2) name: 'B'.
	
	self deny: (firstSeries closeTo: secondSeries).
]

{ #category : #tests }
DataSeriesTest >> testCloseToDifferentValues [

	| firstSeries secondSeries |
	
	firstSeries := DataSeries withKeys: #(a b c) values: #(1 0.1 2) name: 'A'.
	secondSeries := DataSeries withKeys: #(a b c) values: #(1 3.10000001 2) name: 'A'.
	
	self deny: (firstSeries closeTo: secondSeries).
]

{ #category : #tests }
DataSeriesTest >> testCollect [

	| actual expected |
	
	actual := series collect: [ :each |
		each / 10 ].
	
	expected := DataSeries
		withKeys: keyArray
		values: { 3/10 . 7/10 . 3/5 . 2 . 4/5 . 9/10 . 4/5 . 1 . 3/2 . 13/10 . 8/5 }
		name: 'ExampleSeries'.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testCopyCanBeChanged [

	| original seriesCopy expectedCopyAfterChange |
	
	original := DataSeries
		withKeys: #(a b c d)
		values: #(10 30 20 40)
		name: #X.
		
	expectedCopyAfterChange := DataSeries
		withKeys: #(b c d e)
		values: #(100 20 40 200)
		name: #Y.
		
	seriesCopy := original copy.
	
	seriesCopy at: #b put: 100.
	seriesCopy at: #e put: 200.
	seriesCopy removeAt: #a.
	seriesCopy name: #Y.
	
	self assert: seriesCopy equals: expectedCopyAfterChange.
	
]

{ #category : #tests }
DataSeriesTest >> testCopyChangeDoesNotAffectOriginal [

	| original seriesCopy expectedOriginalAfterChange |
	
	original := DataSeries
		withKeys: #(a b c d)
		values: #(10 30 20 40)
		name: #X.
		
	expectedOriginalAfterChange := DataSeries
		withKeys: #(a b c d)
		values: #(10 30 20 40)
		name: #X.
		
	seriesCopy := original copy.
	
	seriesCopy at: #b put: 100.
	seriesCopy at: #e put: 200.
	seriesCopy removeAt: #a.
	seriesCopy name: #Y.
	
	self assert: original equals: expectedOriginalAfterChange.
	
]

{ #category : #tests }
DataSeriesTest >> testCos [

	| a b pi |
	
	pi := Float pi.
	a := { 0 . pi . pi/2 . pi/4 . pi/3 } asDataSeries.
	b := { 1.0 . -1.0 . 0.0 . 1/2 sqrt . 0.5 } asDataSeries.
	
	self assert: a cos closeTo: b.
]

{ #category : #tests }
DataSeriesTest >> testCreateDataSeriesAsDataSeries [

	| dataSeries |
	dataSeries := #(a b c) asDataSeries.
	
	self assert: dataSeries size equals: 3.
	self assert: dataSeries asArray equals: #(a b c).
	self assert: dataSeries keys equals: #(1 2 3).
	self assert: dataSeries name equals: '(no name)'.
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
	self assert: dataSeries name equals: '(no name)'.
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
	self assert: dataSeries name equals: '(no name)'.
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
	self assert: dataSeries name equals: '(no name)'.
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
DataSeriesTest >> testDetect [

	| expected actual |
	
	expected := 7.
	actual := series detect: [ :x | x > 5 ].
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testDetectIfNone [

	| expected actual |
	
	expected := 'not found'.
	actual := series detect: [ :x | x > 100 ] ifNone: [ 'not found' ].
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testDetectNotFound [

	self
		should: [ series detect: [ :x | x > 100 ] ]
		raise: NotFound.
]

{ #category : #tests }
DataSeriesTest >> testDo [

	| sum |
	sum := 0.
	
	series do: [ :each |
		sum := sum + each ].
	
	self assert: sum equals: 115.
]

{ #category : #tests }
DataSeriesTest >> testEighth [

	self assert: series eighth equals: 10.
]

{ #category : #tests }
DataSeriesTest >> testEquality [

	| firstSeries secondSeries |
	
	firstSeries := DataSeries withKeys: #(a b c) values: #(1 0.1 'a') name: 'A'.
	secondSeries := DataSeries withKeys: #(a b c) values: #(1 0.1 'a') name: 'A'.
	
	self assert: firstSeries equals: secondSeries.
]

{ #category : #tests }
DataSeriesTest >> testFifth [

	self assert: series fifth equals: 8.
]

{ #category : #tests }
DataSeriesTest >> testFirst [

	self assert: series first equals: 3.
]

{ #category : #tests }
DataSeriesTest >> testFirstQuartile [

	self assert: series firstQuartile equals: 7.
]

{ #category : #tests }
DataSeriesTest >> testFourth [

	self assert: series fourth equals: 20.
]

{ #category : #tests }
DataSeriesTest >> testFourthQuartile [

	self assert: series fourthQuartile equals: 20.
]

{ #category : #tests }
DataSeriesTest >> testFourthQuartileEqualsMax [

	self assert: series fourthQuartile equals: series max.
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
DataSeriesTest >> testGroupByAggregateUsing [
	| firstSeries secondSeries expected actual |
	
	firstSeries := DataSeries withValues: #(1 10 2 1 5) name: #salary.
	secondSeries := DataSeries withValues: #(Male Female Male Male Female) name: #sex.
	
	expected := DataSeries
		withKeys: #(Female Male)
		values: #(15 4)
		name: #salary.
		
	actual := firstSeries groupBy: secondSeries aggregateUsing: #sum.
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testGroupByAggregateUsingAs [
	| firstSeries secondSeries expected actual |
	
	firstSeries := DataSeries withValues: #(1 10 2 1 5) name: #salary.
	secondSeries := DataSeries withValues: #(Male Female Male Male Female) name: #sex.
	
	expected := DataSeries
		withKeys: #(Female Male)
		values: #(15 4)
		name: #totalSalary.
		
	actual := firstSeries groupBy: secondSeries aggregateUsing: #sum as: #totalSalary.
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testGroupByAggregateUsingAsSizeMismatch [
	| firstSeries secondSeries |
	
	firstSeries := DataSeries withValues: #(1 10 2 1) name: #salary.
	secondSeries := DataSeries withValues: #(Male Female Male Male Female) name: #sex.
		
	self
		should: [ firstSeries groupBy: secondSeries aggregateUsing: #sum as: #totalSalary ]
		raise: SizeMismatch.
]

{ #category : #tests }
DataSeriesTest >> testGroupByAggregateUsingSizeMismatch [
	| firstSeries secondSeries |
	
	firstSeries := DataSeries withValues: #(1 10 2 1 5 100) name: #salary.
	secondSeries := DataSeries withValues: #(Male Female Male Male Female) name: #sex.
		
	self
		should: [ firstSeries groupBy: secondSeries aggregateUsing: #sum ]
		raise: SizeMismatch.
]

{ #category : #tests }
DataSeriesTest >> testHead [
	| expected actual |
	
	expected := DataSeries
		withKeys: #(a b c d e)
		values: #(3 7 6 20 8)
		name: series name.
		
	actual := series head.
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testHeadN [
	| expected actual |
	
	expected := DataSeries
		withKeys: #(a b)
		values: #(3 7)
		name: series name.
		
	actual := series head: 2.
	self assert: actual equals: expected.
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
DataSeriesTest >> testInequalityDifferentKeys [

	| firstSeries secondSeries |
	
	firstSeries := DataSeries withKeys: #(a b c) values: #(1 0.1 'a') name: 'A'.
	secondSeries := DataSeries withKeys: #(x y z) values: #(1 0.1 'a') name: 'A'.
	
	self assert: (firstSeries ~= secondSeries).
]

{ #category : #tests }
DataSeriesTest >> testInequalityDifferentNames [

	| firstSeries secondSeries |
	
	firstSeries := DataSeries withKeys: #(a b c) values: #(1 0.1 'a') name: 'A'.
	secondSeries := DataSeries withKeys: #(a b c) values: #(1 0.1 'a') name: 'B'.
	
	self assert: (firstSeries ~= secondSeries).
]

{ #category : #tests }
DataSeriesTest >> testInequalityDifferentValues [

	| firstSeries secondSeries |
	
	firstSeries := DataSeries withKeys: #(a b c) values: #(1 0.1 'a') name: 'A'.
	secondSeries := DataSeries withKeys: #(a b c) values: #(1 0.2 'a') name: 'A'.
	
	self assert: (firstSeries ~= secondSeries).
]

{ #category : #tests }
DataSeriesTest >> testInjectInto [

	| expected actual |
	
	expected := 115.
	actual := series inject: 0 into: [ :sum :x | sum + x ].
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testInterquartileRange [

	self assert: series interquartileRange equals: 8.
]

{ #category : #tests }
DataSeriesTest >> testLast [

	self assert: series last equals: 16.
]

{ #category : #tests }
DataSeriesTest >> testMax [

	self assert: series max equals: 20.
]

{ #category : #tests }
DataSeriesTest >> testMedian [

	self assert: series median equals: 9.
]

{ #category : #tests }
DataSeriesTest >> testMin [

	self assert: series min equals: 3.
]

{ #category : #tests }
DataSeriesTest >> testMode [

	self assert: series mode equals: 8.
]

{ #category : #tests }
DataSeriesTest >> testNinth [

	self assert: series ninth equals: 15.
]

{ #category : #tests }
DataSeriesTest >> testPowerScalar [

	| a b |
	
	a := #(1 2 3) asDataSeries.
	b := #(1 4 9) asDataSeries.
	
	self assert: a ** 2 equals: b.
]

{ #category : #tests }
DataSeriesTest >> testQuantile [
	
	self assert: (series quantile: 0) equals: 3.
	self assert: (series quantile: 10) equals: 6.
	self assert: (series quantile: 25) equals: 7.
	self assert: (series quantile: 50) equals: 9.
	self assert: (series quantile: 75) equals: 15.
	self assert: (series quantile: 100) equals: 20.
]

{ #category : #tests }
DataSeriesTest >> testQuartile [
	
	self assert: (series quartile: 0) equals: 3.
	self assert: (series quartile: 1) equals: 7.
	self assert: (series quartile: 2) equals: 9.
	self assert: (series quartile: 3) equals: 15.
	self assert: (series quartile: 4) equals: 20.
]

{ #category : #tests }
DataSeriesTest >> testRange [

	self assert: series range equals: 17.
]

{ #category : #tests }
DataSeriesTest >> testReject [

	| expected actual |
	
	expected := DataSeries
		withKeys: #(a b c e f g)
		values: #(3 7 6 8 9 8)
		name: 'ExampleSeries'.
		
	actual := series reject: [ :x | x >= 10 ].
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testRemoveAt [

	| expected |
	
	expected := DataSeries
		withKeys: (keyArray copyWithout: #c)
		values: #(3 7 20 8 9 8 10 15 13 16)
		name: 'ExampleSeries'.
	
	series removeAt: #c.
	
	self assert: series equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testRemoveAtIndex [

	| expected |
	
	expected := DataSeries
		withKeys: (keyArray copyWithout: #c)
		values: #(3 7 20 8 9 8 10 15 13 16)
		name: 'ExampleSeries'.
	
	series removeAtIndex: 3.
	
	self assert: series equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testSecond [

	self assert: series second equals: 7.
]

{ #category : #tests }
DataSeriesTest >> testSecondQuartile [

	self assert: series secondQuartile equals: 9.
]

{ #category : #tests }
DataSeriesTest >> testSecondQuartileEqualsMedian [

	self assert: series secondQuartile equals: series median.
]

{ #category : #tests }
DataSeriesTest >> testSelect [

	| expected actual |
	
	expected := DataSeries
		withKeys: #(a b c e f g)
		values: #(3 7 6 8 9 8)
		name: 'ExampleSeries'.
		
	actual := series select: [ :x | x < 10 ].
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testSeventh [

	self assert: series seventh equals: 8.
]

{ #category : #tests }
DataSeriesTest >> testSin [

	| a b pi |
	
	pi := Float pi.
	a := { 0 . pi . pi/2 . pi/4 . pi/6 } asDataSeries.
	b := { 0.0 . 0.0 . 1.0 . 1/2 sqrt . 0.5 } asDataSeries.
	
	self assert: a sin closeTo: b.
]

{ #category : #tests }
DataSeriesTest >> testSixth [

	self assert: series sixth equals: 9.
]

{ #category : #tests }
DataSeriesTest >> testSort [
	| expected |
	
	expected := DataSeries
		withKeys: #(a c b e g f h j i k d)
		values: #(3 6 7 8 8 9 10 13 15 16 20)
		name: series name.
		
	series sort.
	self assert: series equals: expected
]

{ #category : #tests }
DataSeriesTest >> testSortBlock [
	| expected |
	
	expected := DataSeries
		withKeys: #(k j i h d g f e c b a)
		values: #(16 13 15 10 20 8 9 8 6 7 3)
		name: series name.
		
	series sort: [ :a :b | a asString size > b asString size ].
	self assert: series equals: expected
]

{ #category : #tests }
DataSeriesTest >> testSortDescending [
	| expected |
	
	expected := DataSeries
		withKeys: #(d k i j h f g e b c a)
		values: #(20 16 15 13 10 9 8 8 7 6 3)
		name: series name.
		
	series sortDescending.
	self assert: series equals: expected
]

{ #category : #tests }
DataSeriesTest >> testSorted [
	| expected actual |
	
	expected := DataSeries
		withKeys: #(a c b e g f h j i k d)
		values: #(3 6 7 8 8 9 10 13 15 16 20)
		name: series name.
		
	actual := series sorted.
	self assert: actual equals: expected
]

{ #category : #tests }
DataSeriesTest >> testSortedBlock [
	| expected actual |
	
	expected := DataSeries
		withKeys: #(k j i h d g f e c b a)
		values: #(16 13 15 10 20 8 9 8 6 7 3)
		name: series name.
		
	actual := series sorted: [ :a :b | a asString size > b asString size ].
	self assert: actual equals: expected
]

{ #category : #tests }
DataSeriesTest >> testSortedBlockDoesNotChangeTheReceiver [
	| expected |
	
	expected := DataSeries
		withKeys: #(a b c d e f g h i j k)
		values: #(3 7 6 20 8 9 8 10 15 13 16)
		name: series name.
		
	series sorted: [ :a :b | a asString size > b asString size ].
	self assert: series equals: expected
]

{ #category : #tests }
DataSeriesTest >> testSortedDescending [
	| expected actual |
	
	expected := DataSeries
		withKeys: #(d k i j h f g e b c a)
		values: #(20 16 15 13 10 9 8 8 7 6 3)
		name: series name.
		
	actual := series sortedDescending.
	self assert: actual equals: expected
]

{ #category : #tests }
DataSeriesTest >> testSortedDescendingDoesNotChangeTheReceiver [
	| expected |
	
	expected := DataSeries
		withKeys: #(a b c d e f g h i j k)
		values: #(3 7 6 20 8 9 8 10 15 13 16)
		name: series name.
		
	series sortedDescending.
	self assert: series equals: expected
]

{ #category : #tests }
DataSeriesTest >> testSortedDoesNotChangeTheReceiver [
	| expected |
	
	expected := DataSeries
		withKeys: #(a b c d e f g h i j k)
		values: #(3 7 6 20 8 9 8 10 15 13 16)
		name: series name.
		
	series sorted.
	self assert: series equals: expected
]

{ #category : #tests }
DataSeriesTest >> testStdev [

	self assert: series stdev closeTo: 5.00727.
]

{ #category : #tests }
DataSeriesTest >> testSummary [
	| expected actual |
	
	expected := DataSeries 
		withKeys: #(Min '1st Qu.' Median Average '3rd Qu.' Max)
		values: { 3 . 7 . 9 . (115 / 11) . 15 . 20 }
		name: series name.
		
	actual := series summary.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testTail [
	| expected actual |
	
	expected := DataSeries
		withKeys: #(g h i j k)
		values: #(8 10 15 13 16)
		name: series name.
		
	actual := series tail.
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testTailN [
	| expected actual |
	
	expected := DataSeries
		withKeys: #(j k)
		values: #(13 16)
		name: series name.
		
	actual := series tail: 2.
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testThird [

	self assert: series third equals: 6.
]

{ #category : #tests }
DataSeriesTest >> testThirdQuartile [

	self assert: series thirdQuartile equals: 15.
]

{ #category : #tests }
DataSeriesTest >> testUniqueValues [
	| aSeries expected actual |
	aSeries := DataSeries withKeys: #(a b c d e) values: #(z y y z x).
	expected := #(x y z).
	actual := aSeries uniqueValues.
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testValueCounts [
	| actual expected |
	
	expected := DataSeries 
		withKeys: #(8 20 16 15 13 10 9 7 6 3)
		values: #(2 1 1 1 1 1 1 1 1 1)
		name: series name.
		
	actual := series valueCounts.
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testVariance [

	self assert: series variance closeTo: 25.07273.
]

{ #category : #tests }
DataSeriesTest >> testWithIndexCollect [

	| actual expected |
	
	actual := series withIndexCollect: [ :each :i |
		each / 10 + i ].
	
	expected := DataSeries
		withKeys: keyArray
		values: {(13/10). (27/10). (18/5). 6. (29/5). (69/10). (39/5). 9. (21/2). (113/10). (63/5)}
		name: 'ExampleSeries'.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testWithIndexDetect [

	| expected actual |
	
	expected := 6.
	actual := series withIndexDetect: [ :x :i | (x > 5) and: (i odd) ].
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testWithIndexDetectIfNone [

	| expected actual |
	
	expected := 'not found'.
	actual := series withIndexDetect: [ :x :i | i > 100 ] ifNone: [ 'not found' ].
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testWithIndexDetectNotFound [

	self
		should: [ series withIndexDetect: [ :x :i | i > 100 ] ]
		raise: NotFound.
]

{ #category : #tests }
DataSeriesTest >> testWithIndexDo [

	| sum |
	sum := 0.
	
	series withIndexDo: [ :each :i |
		sum := sum + (each / i) ].
	
	self assert: sum equals: (108173/4620).
]

{ #category : #tests }
DataSeriesTest >> testWithIndexReject [

	| expected actual |
	
	expected := DataSeries
		withKeys: #(a c e g)
		values: #(3 6 8 8)
		name: 'ExampleSeries'.
		
	actual := series withIndexReject: [ :x :i | x >= 10 or: i even ].
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testWithIndexSelect [

	| expected actual |
	
	expected := DataSeries
		withKeys: #(a c e g)
		values: #(3 6 8 8)
		name: 'ExampleSeries'.
		
	actual := series withIndexSelect: [ :x :i | x < 10 and: i odd ].
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testWithKeyCollect [

	| actual expected |
	
	actual := series withKeyCollect: [ :each :key |
		each / 10 + (keyArray indexOf: key) ].
	
	expected := DataSeries
		withKeys: keyArray
		values: {(13/10). (27/10). (18/5). 6. (29/5). (69/10). (39/5). 9. (21/2). (113/10). (63/5)}
		name: 'ExampleSeries'.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testWithKeyDetect [

	| expected actual |
	
	expected := 6.
	actual := series withKeyDetect: [ :x :k | x > 5 and: (k = #c) ].
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testWithKeyDetectIfNone [

	| expected actual |
	
	expected := 'not found'.
	actual := series withKeyDetect: [ :x :k | x > 5 and: (k = #NoSuchKey) ] ifNone: [ 'not found' ].
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testWithKeyDetectNotFound [

	self
		should: [ series withKeyDetect: [ :x :k | x > 5 and: (k = #NoSuchKey) ] ]
		raise: NotFound.
]

{ #category : #tests }
DataSeriesTest >> testWithKeyDo [

	| sum |
	sum := 0.
	
	series withKeyDo: [ :each :key |
		sum := sum + (each / (keyArray indexOf: key)) ].
	
	self assert: sum equals: (108173/4620).
]

{ #category : #tests }
DataSeriesTest >> testWithKeyReject [

	| expected actual |
	
	expected := DataSeries
		withKeys: #(a c g)
		values: #(3 6 8)
		name: 'ExampleSeries'.
		
	actual := series withKeyReject: [ :x :k | x >= 10 or: (#(a c g) includes: k) not ].
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testWithKeySelect [

	| expected actual |
	
	expected := DataSeries
		withKeys: #(a c g)
		values: #(3 6 8)
		name: 'ExampleSeries'.
		
	actual := series withKeySelect: [ :x :k | x < 10 and: (#(a c g) includes: k) ].
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSeriesTest >> testZerothQuartile [

	self assert: series zerothQuartile equals: 3.
]

{ #category : #tests }
DataSeriesTest >> testZerothQuartileEqualsMin [

	self assert: series zerothQuartile equals: series min.
]
