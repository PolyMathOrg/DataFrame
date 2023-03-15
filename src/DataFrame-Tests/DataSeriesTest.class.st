Class {
	#name : #DataSeriesTest,
	#superclass : #TestCase,
	#instVars : [
		'series',
		'keyArray'
	],
	#category : #'DataFrame-Tests'
}

{ #category : #running }
DataSeriesTest >> setUp [

	super setUp.
	keyArray := #( a b c d e f g h i j k ).

	series := DataSeries withKeys: keyArray values: #( 3 7 6 20 8 9 8 10 15 13 16 ) name: 'ExampleSeries'
]

{ #category : #'tests - arithmetic' }
DataSeriesTest >> testArithmeticsAddArrayToSeries [

	| array actual expected |
	series := DataSeries withKeys: #( a b c ) values: #( 1 2 3 ) name: #X.
	array := #( 3 4 5 ).

	expected := DataSeries withKeys: #( a b c ) values: #( 4 6 8 ) name: #X.
	actual := series + array.

	self assert: actual equals: expected
]

{ #category : #'tests - arithmetic' }
DataSeriesTest >> testArithmeticsAddScalarToSeries [

	| scalar actual expected |
	series := DataSeries withKeys: #( a b c ) values: #( 1 2 3 ) name: #X.
	scalar := 10.

	expected := DataSeries withKeys: #( a b c ) values: #( 11 12 13 ) name: #X.
	actual := series + scalar.

	self assert: actual equals: expected
]

{ #category : #'tests - arithmetic' }
DataSeriesTest >> testArithmeticsAddSeriesToArray [

	| array actual expected |
	array := #( 1 2 3 ).
	series := DataSeries withKeys: #( a b c ) values: #( 3 4 5 ) name: #X.

	expected := DataSeries withKeys: #( a b c ) values: #( 4 6 8 ) name: #X.
	actual := array + series.

	self assert: actual equals: expected
]

{ #category : #'tests - arithmetic' }
DataSeriesTest >> testArithmeticsAddSeriesToScalar [

	| scalar actual expected |
	scalar := 10.
	series := DataSeries withKeys: #( a b c ) values: #( 3 4 5 ) name: #X.

	expected := DataSeries withKeys: #( a b c ) values: #( 13 14 15 ) name: #X.
	actual := scalar + series.

	self assert: actual equals: expected
]

{ #category : #'tests - arithmetic' }
DataSeriesTest >> testArithmeticsAddSeriesToSeriesDifferentKeys [
	| firstSeries secondSeries |

	firstSeries := DataSeries withKeys: #(x y z) values: #(1 2 3) name: #X.
	secondSeries := DataSeries withKeys: #(a b c) values: #(3 4 5) name: #X.

	self should: [ firstSeries + secondSeries ] raise: Error
]

{ #category : #'tests - arithmetic' }
DataSeriesTest >> testArithmeticsAddSeriesToSeriesSameKeysAndName [
	| firstSeries secondSeries actual expected |

	firstSeries := DataSeries withKeys: #(a b c) values: #(1 2 3) name: #X.
	secondSeries := DataSeries withKeys: #(a b c) values: #(3 4 5) name: #X.

	expected := DataSeries withKeys: #(a b c) values: #(4 6 8) name: #X.
	actual := firstSeries + secondSeries.

	self assert: actual equals: expected
]

{ #category : #'tests - arithmetic' }
DataSeriesTest >> testArithmeticsAddSeriesToSeriesSameKeysDifferentName [
	| firstSeries secondSeries actual expected |

	firstSeries := DataSeries withKeys: #(a b c) values: #(1 2 3) name: #X.
	secondSeries := DataSeries withKeys: #(a b c) values: #(3 4 5) name: #Y.

	expected := DataSeries withKeys: #(a b c) values: #(4 6 8) name: #X.
	actual := firstSeries + secondSeries.

	self assert: actual equals: expected
]

{ #category : #'tests - arithmetic' }
DataSeriesTest >> testArithmeticsDivideArrayBySeries [

	| array a b |

	array := #(2 4 3).
	a := #(1 2 3) asDataSeries.
	b := { 2 . 2 . 1 } asDataSeries.

	self assert: array / a equals: b
]

{ #category : #'tests - arithmetic' }
DataSeriesTest >> testArithmeticsDivideSeriesByArray [

	| array a b |

	array := #(2 4 3).
	a := #(1 2 3) asDataSeries.
	b := { 1/2 . 1/2 . 1 } asDataSeries.

	self assert: a / array equals: b
]

{ #category : #'tests - arithmetic' }
DataSeriesTest >> testArithmeticsDivideSeriesByScalar [

	| a b |

	a := #(1 2 3) asDataSeries.
	b := #(0.5 1 1.5) asDataSeries.

	self assert: a / 2 equals: b
]

{ #category : #'tests - arithmetic' }
DataSeriesTest >> testArithmeticsDivideSeriesBySeries [

	| a b c |

	a := #(2 4 3) asDataSeries.
	b := #(1 2 3) asDataSeries.
	c := { 2 . 2 . 1 } asDataSeries.

	self assert: a / b equals: c
]

{ #category : #'tests - arithmetic' }
DataSeriesTest >> testArithmeticsDivideSeriesBySeriesDifferentKeys [
	| firstSeries secondSeries |

	firstSeries := DataSeries withKeys: #(x y z) values: #(1 2 3) name: #X.
	secondSeries := DataSeries withKeys: #(a b c) values: #(3 4 5) name: #X.

	self should: [ firstSeries / secondSeries ] raise: Error
]

{ #category : #'tests - arithmetic' }
DataSeriesTest >> testArithmeticsDivideSeriesBySeriesSameKeysAndName [
	| firstSeries secondSeries actual expected |

	firstSeries := DataSeries withKeys: #(a b c) values: #(1 2 3) name: #X.
	secondSeries := DataSeries withKeys: #(a b c) values: #(3 4 5) name: #X.

	expected := DataSeries withKeys: #(a b c) values: { 1/3 . 1/2 . 3/5 } name: #X.
	actual := firstSeries / secondSeries.

	self assert: actual equals: expected
]

{ #category : #'tests - arithmetic' }
DataSeriesTest >> testArithmeticsDivideSeriesBySeriesSameKeysDifferentName [
	| firstSeries secondSeries actual expected |

	firstSeries := DataSeries withKeys: #(a b c) values: #(1 2 3) name: #X.
	secondSeries := DataSeries withKeys: #(a b c) values: #(3 4 5) name: #Y.

	expected := DataSeries withKeys: #(a b c) values: { 1/3 . 1/2 . 3/5 } name: #X.
	actual := firstSeries / secondSeries.

	self assert: actual equals: expected
]

{ #category : #'tests - arithmetic' }
DataSeriesTest >> testArithmeticsDivideSeriesBySeriesWithNils [

	| a b c |
	a := #( 2 4 nil ) asDataSeries.
	b := #( 1 nil 3 ) asDataSeries.
	c := #( 2 nil nil ) asDataSeries.

	self assert: a / b equals: c
]

{ #category : #'tests - arithmetic' }
DataSeriesTest >> testArithmeticsMultiplyArrayBySeries [

	| array a b |

	array := #(2 4 3).
	a := #(1 2 3) asDataSeries.
	b := #(2 8 9) asDataSeries.

	self assert: array * a equals: b
]

{ #category : #'tests - arithmetic' }
DataSeriesTest >> testArithmeticsMultiplyScalarBySeries [

	| a b |

	a := #(1 2 3) asDataSeries.
	b := #(2 4 6) asDataSeries.

	self assert: 2 * a equals: b
]

{ #category : #'tests - arithmetic' }
DataSeriesTest >> testArithmeticsMultiplySeriesByArray [

	| array a b |

	array := #(2 4 3).
	a := #(1 2 3) asDataSeries.
	b := #(2 8 9) asDataSeries.

	self assert: a * array equals: b
]

{ #category : #'tests - arithmetic' }
DataSeriesTest >> testArithmeticsMultiplySeriesByScalar [

	| a b |

	a := #(1 2 3) asDataSeries.
	b := #(2 4 6) asDataSeries.

	self assert: a * 2 equals: b
]

{ #category : #'tests - arithmetic' }
DataSeriesTest >> testArithmeticsMultiplySeriesBySeries [

	| a b c |

	a := #(2 4 3) asDataSeries.
	b := #(1 2 3) asDataSeries.
	c := #(2 8 9) asDataSeries.

	self assert: a * b equals: c
]

{ #category : #'tests - arithmetic' }
DataSeriesTest >> testArithmeticsMultiplySeriesBySeriesDifferentKeys [
	| firstSeries secondSeries |

	firstSeries := DataSeries withKeys: #(x y z) values: #(1 2 3) name: #X.
	secondSeries := DataSeries withKeys: #(a b c) values: #(3 4 5) name: #X.

	self should: [ firstSeries * secondSeries ] raise: Error
]

{ #category : #'tests - arithmetic' }
DataSeriesTest >> testArithmeticsMultiplySeriesBySeriesSameKeysAndName [
	| firstSeries secondSeries actual expected |

	firstSeries := DataSeries withKeys: #(a b c) values: #(1 2 3) name: #X.
	secondSeries := DataSeries withKeys: #(a b c) values: #(3 4 5) name: #X.

	expected := DataSeries withKeys: #(a b c) values: #(3 8 15) name: #X.
	actual := firstSeries * secondSeries.

	self assert: actual equals: expected
]

{ #category : #'tests - arithmetic' }
DataSeriesTest >> testArithmeticsMultiplySeriesBySeriesSameKeysDifferentName [
	| firstSeries secondSeries actual expected |

	firstSeries := DataSeries withKeys: #(a b c) values: #(1 2 3) name: #X.
	secondSeries := DataSeries withKeys: #(a b c) values: #(3 4 5) name: #Y.

	expected := DataSeries withKeys: #(a b c) values: #(3 8 15) name: #X.
	actual := firstSeries * secondSeries.

	self assert: actual equals: expected
]

{ #category : #'tests - arithmetic' }
DataSeriesTest >> testArithmeticsSubtractArrayFromSeries [

	| array a b |

	array := #(2 4 3).
	a := #(1 2 3) asDataSeries.
	b := #(-1 -2 0) asDataSeries.

	self assert: a - array equals: b
]

{ #category : #'tests - arithmetic' }
DataSeriesTest >> testArithmeticsSubtractScalarFromSeries [

	| a b |

	a := #(1 2 3) asDataSeries.
	b := #(-1 0 1) asDataSeries.

	self assert: a - 2 equals: b
]

{ #category : #'tests - arithmetic' }
DataSeriesTest >> testArithmeticsSubtractSeriesFromArray [

	| array a b |

	array := #(2 4 3).
	a := #(1 2 3) asDataSeries.
	b := #(1 2 0) asDataSeries.

	self assert: array - a equals: b
]

{ #category : #'tests - arithmetic' }
DataSeriesTest >> testArithmeticsSubtractSeriesFromScalar [

	| a b |

	a := #(1 2 3) asDataSeries.
	b := #(1 0 -1) asDataSeries.

	self assert: 2 - a equals: b
]

{ #category : #'tests - arithmetic' }
DataSeriesTest >> testArithmeticsSubtractSeriesFromSeries [

	| a b c |

	a := #(2 4 3) asDataSeries.
	b := #(1 2 3) asDataSeries.
	c := #(1 2 0) asDataSeries.

	self assert: a - b equals: c
]

{ #category : #'tests - arithmetic' }
DataSeriesTest >> testArithmeticsSubtractSeriesFromSeriesDifferentKeys [
	| firstSeries secondSeries |

	firstSeries := DataSeries withKeys: #(x y z) values: #(1 2 3) name: #X.
	secondSeries := DataSeries withKeys: #(a b c) values: #(3 4 5) name: #X.

	self should: [ firstSeries - secondSeries ] raise: Error
]

{ #category : #'tests - arithmetic' }
DataSeriesTest >> testArithmeticsSubtractSeriesFromSeriesSameKeysAndName [
	| firstSeries secondSeries actual expected |

	firstSeries := DataSeries withKeys: #(a b c) values: #(1 2 3) name: #X.
	secondSeries := DataSeries withKeys: #(a b c) values: #(3 4 5) name: #X.

	expected := DataSeries withKeys: #(a b c) values: #(-2 -2 -2) name: #X.
	actual := firstSeries - secondSeries.

	self assert: actual equals: expected
]

{ #category : #'tests - arithmetic' }
DataSeriesTest >> testArithmeticsSubtractSeriesFromSeriesSameKeysDifferentName [
	| firstSeries secondSeries actual expected |

	firstSeries := DataSeries withKeys: #(a b c) values: #(1 2 3) name: #X.
	secondSeries := DataSeries withKeys: #(a b c) values: #(3 4 5) name: #Y.

	expected := DataSeries withKeys: #(a b c) values: #(-2 -2 -2) name: #X.
	actual := firstSeries - secondSeries.

	self assert: actual equals: expected
]

{ #category : #'tests - converting' }
DataSeriesTest >> testAsDataFrame [
	| expected actual |

	expected := DataFrame
		withColumns: #((3 7 6 20 8 9 8 10 15 13 16))
		rowNames: #(a b c d e f g h i j k)
		columnNames: #(ExampleSeries).

	actual := series asDataFrame.
	self assert: actual equals: expected
]

{ #category : #'tests - creation' }
DataSeriesTest >> testAsDataSeriesEmpty [

	| dataseries expected |

	dataseries := #() asDataSeries.
	expected := DataSeries new.

	self assert: dataseries equals: expected
]

{ #category : #'tests - converting' }
DataSeriesTest >> testAsDictionary [
	| expected actual |

	expected := {
		'a' -> 3 . 'b' -> 7 . 'c' -> 6 . 'd' -> 20 .
		'e' -> 8 . 'f' -> 9 . 'g' -> 8 . 'h' -> 10 .
		'i' -> 15 . 'j' -> 13 . 'k' -> 16 } asDictionary.

	actual := series asDictionary.
	self assert: actual equals: expected
]

{ #category : #'tests - accessing' }
DataSeriesTest >> testAt [

	self assert: (series at: #b) equals: 7
]

{ #category : #'tests - accessing' }
DataSeriesTest >> testAtIndex [

	self assert: (series atIndex: 2) equals: 7
]

{ #category : #'tests - accessing' }
DataSeriesTest >> testAtIndexPut [

	| expected |

	series atIndex: 6 put: -2.

	expected := DataSeries
		withKeys: keyArray
		values: #(3 7 6 20 8 -2 8 10 15 13 16)
		name: series name.

	self assert: series equals: expected
]

{ #category : #'tests - accessing' }
DataSeriesTest >> testAtIndexTransform [

	| expected |

	series atIndex: 6 transform: [ :x | x + 1 ].

	expected := DataSeries
		withKeys: keyArray
		values: #(3 7 6 20 8 10 8 10 15 13 16)
		name: series name.

	self assert: series equals: expected
]

{ #category : #'tests - accessing' }
DataSeriesTest >> testAtPut [

	| expected |

	series at: #f put: -2.

	expected := DataSeries
		withKeys: keyArray
		values: #(3 7 6 20 8 -2 8 10 15 13 16)
		name: series name.

	self assert: series equals: expected
]

{ #category : #'tests - accessing' }
DataSeriesTest >> testAtPutNewElement [

	| expected |

	series at: #X put: -2.

	expected := DataSeries
		withKeys: (keyArray copyWith: #X)
		values: #(3 7 6 20 8 9 8 10 15 13 16 -2)
		name: series name.

	self assert: series equals: expected
]

{ #category : #'tests - accessing' }
DataSeriesTest >> testAtTransform [

	| expected |

	series at: #f transform: [ :x | x + 1 ].

	expected := DataSeries
		withKeys: keyArray
		values: #(3 7 6 20 8 10 8 10 15 13 16)
		name: series name.

	self assert: series equals: expected
]

{ #category : #'tests - accessing' }
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
	self assert: exceptionBlockEvaluated
]

{ #category : #'tests - comparing' }
DataSeriesTest >> testBooleanGreaterThanEqualFromScalar [

	| aSeries expected |

	aSeries := DataSeries withKeys: #(1 2 3) values: #(1 0.4 8).
	expected := DataSeries withKeys: #(1 2 3) values: #(true true false).

	self assert: 1 >= aSeries equals: expected
]

{ #category : #'tests - comparing' }
DataSeriesTest >> testBooleanGreaterThanEqualWithArray [

	| aSeries expected |

	aSeries := DataSeries withKeys: #(1 2 3) values: #(1 0.4 'a').
	expected := DataSeries withKeys: #(1 2 3) values: #(true true false).

	self assert: aSeries >= #(1 0.1 'b') equals: expected
]

{ #category : #'tests - comparing' }
DataSeriesTest >> testBooleanGreaterThanEqualWithScalar [

	| firstSeries expected |

	firstSeries := DataSeries withKeys: #(a b c) values: #(0.8 0.4 1).
	expected := DataSeries withKeys: #(a b c) values: #(true false true).

	self assert: firstSeries >= 0.8 equals: expected
]

{ #category : #'tests - comparing' }
DataSeriesTest >> testBooleanGreaterThanEqualWithSeries [

	| firstSeries secondSeries expected |

	firstSeries := DataSeries withKeys: #(1 2 3) values: #(1 0.4 'a').
	secondSeries := DataSeries withKeys: #(1 2 3) values: #(1 0.1 'b').
	expected := DataSeries withKeys: #(1 2 3) values: #(true true false).

	self assert: firstSeries >= secondSeries equals: expected
]

{ #category : #'tests - comparing' }
DataSeriesTest >> testBooleanGreaterThanEqualWithSeriesDifferentKeys [

	| firstSeries secondSeries |

	firstSeries := DataSeries withKeys: #(a b c) values: #(1 0.4 'a').
	secondSeries := DataSeries withKeys: #(1 2 3) values: #(1 0.1 'b').

	self should: [ firstSeries >= secondSeries ] raise: Error
]

{ #category : #'tests - comparing' }
DataSeriesTest >> testBooleanGreaterThanEqualWithSeriesDifferentNames [

	| firstSeries secondSeries expected |

	firstSeries := DataSeries withKeys: #(1 2 3) values: #(1 0.4 'a') name: 'firstSeries'.
	secondSeries := DataSeries withKeys: #(1 2 3) values: #(1 0.1 'b') name: 'secondSeries'.
	expected := DataSeries withKeys: #(1 2 3) values: #(true true false) name: 'firstSeries'.

	self assert: firstSeries >= secondSeries equals: expected
]

{ #category : #'tests - comparing' }
DataSeriesTest >> testBooleanGreaterThanFromScalar [

	| aSeries expected |

	aSeries := DataSeries withKeys: #(1 2 3) values: #(1 0.4 8).
	expected := DataSeries withKeys: #(1 2 3) values: #(false true false).

	self assert: 1 > aSeries equals: expected
]

{ #category : #'tests - comparing' }
DataSeriesTest >> testBooleanGreaterThanWithArray [

	| aSeries expected |

	aSeries := DataSeries withKeys: #(1 2 3) values: #(1 0.4 'a').
	expected := DataSeries withKeys: #(1 2 3) values: #(false true false).

	self assert: aSeries > #(1 0.1 'b') equals: expected
]

{ #category : #'tests - comparing' }
DataSeriesTest >> testBooleanGreaterThanWithScalar [

	| firstSeries expected |

	firstSeries := DataSeries withKeys: #(a b c) values: #(0.8 0.4 1).
	expected := DataSeries withKeys: #(a b c) values: #(true false true).

	self assert: firstSeries >= 0.8 equals: expected
]

{ #category : #'tests - comparing' }
DataSeriesTest >> testBooleanGreaterThanWithSeries [

	| firstSeries secondSeries expected |

	firstSeries := DataSeries withKeys: #(1 2 3) values: #(1 0.4 'a').
	secondSeries := DataSeries withKeys: #(1 2 3) values: #(1 0.1 'b').
	expected := DataSeries withKeys: #(1 2 3) values: #(false true false).

	self assert: firstSeries > secondSeries equals: expected
]

{ #category : #'tests - comparing' }
DataSeriesTest >> testBooleanGreaterThanWithSeriesDifferentKeys [

	| firstSeries secondSeries |

	firstSeries := DataSeries withKeys: #(a b c) values: #(1 0.4 'a').
	secondSeries := DataSeries withKeys: #(1 2 3) values: #(1 0.1 'b').

	self should: [ firstSeries > secondSeries ] raise: Error
]

{ #category : #'tests - comparing' }
DataSeriesTest >> testBooleanGreaterThanWithSeriesDifferentNames [

	| firstSeries secondSeries expected |

	firstSeries := DataSeries withKeys: #(1 2 3) values: #(1 0.4 'a') name: 'firstSeries'.
	secondSeries := DataSeries withKeys: #(1 2 3) values: #(1 0.1 'b') name: 'secondSeries'.
	expected := DataSeries withKeys: #(1 2 3) values: #(false true false) name: 'firstSeries'.

	self assert: firstSeries > secondSeries equals: expected
]

{ #category : #'tests - comparing' }
DataSeriesTest >> testBooleanLessThanEqualFromScalar [

	| aSeries expected |

	aSeries := DataSeries withKeys: #(1 2 3) values: #(1 0.4 8).
	expected := DataSeries withKeys: #(1 2 3) values: #(true false true).

	self assert: 1 <= aSeries equals: expected
]

{ #category : #'tests - comparing' }
DataSeriesTest >> testBooleanLessThanEqualWithArray [

	| aSeries expected |

	aSeries := DataSeries withKeys: #(1 2 3) values: #(1 0.4 'a').
	expected := DataSeries withKeys: #(1 2 3) values: #(true false true).

	self assert: aSeries <= #(1 0.1 'b') equals: expected
]

{ #category : #'tests - comparing' }
DataSeriesTest >> testBooleanLessThanEqualWithScalar [

	| firstSeries expected |

	firstSeries := DataSeries withKeys: #(a b c) values: #(0.8 0.4 1).
	expected := DataSeries withKeys: #(a b c) values: #(true true false).

	self assert: firstSeries <= 0.8 equals: expected
]

{ #category : #'tests - comparing' }
DataSeriesTest >> testBooleanLessThanEqualWithSeries [

	| firstSeries secondSeries expected |

	firstSeries := DataSeries withKeys: #(a b c) values: #(1 0.4 'a').
	secondSeries := DataSeries withKeys: #(a b c) values: #(1 0.1 'b').
	expected := DataSeries withKeys: #(a b c) values: #(true false true).

	self assert: firstSeries <= secondSeries equals: expected
]

{ #category : #'tests - comparing' }
DataSeriesTest >> testBooleanLessThanEqualWithSeriesDifferentKeys [

	| firstSeries secondSeries |

	firstSeries := DataSeries withKeys: #(a b c) values: #(1 0.4 'a').
	secondSeries := DataSeries withKeys: #(1 2 3) values: #(1 0.1 'b').

	self should: [ firstSeries <= secondSeries ] raise: Error
]

{ #category : #'tests - comparing' }
DataSeriesTest >> testBooleanLessThanEqualWithSeriesDifferentNames [

	| firstSeries secondSeries expected |

	firstSeries := DataSeries withKeys: #(1 2 3) values: #(1 0.4 'a') name: 'firstSeries'.
	secondSeries := DataSeries withKeys: #(1 2 3) values: #(1 0.1 'b') name: 'secondSeries'.
	expected := DataSeries withKeys: #(1 2 3) values: #(true false true) name: 'firstSeries'.

	self assert: firstSeries <= secondSeries equals: expected
]

{ #category : #'tests - comparing' }
DataSeriesTest >> testBooleanLessThanFromScalar [

	| aSeries expected |

	aSeries := DataSeries withKeys: #(1 2 3) values: #(1 0.4 8).
	expected := DataSeries withKeys: #(1 2 3) values: #(false false true).

	self assert: 1 < aSeries equals: expected
]

{ #category : #'tests - comparing' }
DataSeriesTest >> testBooleanLessThanWithArray [

	| aSeries expected |

	aSeries := DataSeries withKeys: #(1 2 3) values: #(1 0.4 'a').
	expected := DataSeries withKeys: #(1 2 3) values: #(false false true).

	self assert: aSeries < #(1 0.1 'b') equals: expected
]

{ #category : #'tests - comparing' }
DataSeriesTest >> testBooleanLessThanWithScalar [

	| firstSeries expected |

	firstSeries := DataSeries withKeys: #(a b c) values: #(0.8 0.4 1).
	expected := DataSeries withKeys: #(a b c) values: #(false true false).

	self assert: firstSeries < 0.8 equals: expected
]

{ #category : #'tests - comparing' }
DataSeriesTest >> testBooleanLessThanWithSeries [

	| firstSeries secondSeries expected |

	firstSeries := DataSeries withKeys: #(a b c) values: #(1 0.4 'a').
	secondSeries := DataSeries withKeys: #(a b c) values: #(1 0.1 'b').
	expected := DataSeries withKeys: #(a b c) values: #(false false true).

	self assert: firstSeries < secondSeries equals: expected
]

{ #category : #'tests - comparing' }
DataSeriesTest >> testBooleanLessThanWithSeriesDifferentKeys [

	| firstSeries secondSeries |

	firstSeries := DataSeries withKeys: #(a b c) values: #(1 0.4 'a').
	secondSeries := DataSeries withKeys: #(1 2 3) values: #(1 0.1 'b').

	self should: [ firstSeries < secondSeries ] raise: Error
]

{ #category : #'tests - comparing' }
DataSeriesTest >> testBooleanLessThanWithSeriesDifferentNames [

	| firstSeries secondSeries expected |

	firstSeries := DataSeries withKeys: #(1 2 3) values: #(1 0.4 'a') name: 'firstSeries'.
	secondSeries := DataSeries withKeys: #(1 2 3) values: #(1 0.1 'b') name: 'secondSeries'.
	expected := DataSeries withKeys: #(1 2 3) values: #(false false true) name: 'firstSeries'.

	self assert: firstSeries < secondSeries equals: expected
]

{ #category : #'tests - datatypes' }
DataSeriesTest >> testCalculateDataType [

	| newSeries |
	self assert: series calculateDataType equals: SmallInteger.
	newSeries := DataSeries new.
	self assert: newSeries calculateDataType equals: UndefinedObject
]

{ #category : #'tests - arithmetic' }
DataSeriesTest >> testCategoricalCanBeMadeCategorical [

	| categoricalSeries |
	categoricalSeries := #(small medium large) asDataSeries.
	self assert: categoricalSeries makeCategorical isCategorical
]

{ #category : #'tests - arithmetic' }
DataSeriesTest >> testCategoricalCanBeMadeNumerical [

	| categoricalSeries |
	categoricalSeries := #(small medium large) asDataSeries.
	self assert: categoricalSeries makeNumerical isNumerical
]

{ #category : #'tests - categorical' }
DataSeriesTest >> testCategoricalCrossTabulateWith [

	| series1 series2 expected |
	series1 := #(A B C A A B C A B B) asDataSeries.
	series2 := #(1 2 1 2 1 1 2 1 2 2) asDataSeries.

	expected := DataFrame withRows:
		#((3 1)(1 3)(1 1)).

	expected rowNames: #(A B C).
	expected columnNames: #(1 2).

	self assert: (series1 crossTabulateWith: series2) equals: expected
]

{ #category : #'tests - arithmetic' }
DataSeriesTest >> testCategoricalIsCategorical [

	| categoricalSeries |
	categoricalSeries := #(small medium large) asDataSeries.
	self assert: categoricalSeries isCategorical
]

{ #category : #'tests - arithmetic' }
DataSeriesTest >> testCategoricalIsNotNumerical [

	| categoricalSeries |
	categoricalSeries := #(small medium large) asDataSeries.
	self deny: categoricalSeries isNumerical
]

{ #category : #'tests - categorical' }
DataSeriesTest >> testCategoricalUniqueValues [
	| aSeries expected actual |
	aSeries := DataSeries withKeys: #(a b c d e) values: #(z y y z x).
	expected := #(x y z).
	actual := aSeries uniqueValues.
	self assert: actual equals: expected
]

{ #category : #'tests - categorical' }
DataSeriesTest >> testCategoricalValueCounts [
	| actual expected |

	expected := DataSeries
		withKeys: #(8 20 16 15 13 10 9 7 6 3)
		values: #(2 1 1 1 1 1 1 1 1 1)
		name: series name.

	actual := series valueCounts.
	self assert: actual equals: expected
]

{ #category : #'tests - categorical' }
DataSeriesTest >> testCategoricalValueFrequencies [

	| aSeries expected actual |
	aSeries := DataSeries
		withValues: #(A B C A A B C A B B)
		name: #X.

	expected := DataSeries
		withKeys: #(B A C)
		values: { 2/5 . 2/5 . 1/5 }
		name: #X.

	actual := aSeries valueFrequencies.

	self assert: actual equals: expected
]

{ #category : #'tests - comparing' }
DataSeriesTest >> testCloseTo [

	| firstSeries secondSeries |

	firstSeries := DataSeries withKeys: #(a b c) values: #(1 0.1 2) name: 'A'.
	secondSeries := DataSeries withKeys: #(a b c) values: #(1 0.10000001 2) name: 'A'.

	self assert: firstSeries closeTo: secondSeries
]

{ #category : #'tests - comparing' }
DataSeriesTest >> testCloseToDifferentKeys [

	| firstSeries secondSeries |

	firstSeries := DataSeries withKeys: #(a b c) values: #(1 0.1 2) name: 'A'.
	secondSeries := DataSeries withKeys: #(x y z) values: #(1 0.10000001 2) name: 'A'.

	self deny: (firstSeries closeTo: secondSeries)
]

{ #category : #'tests - comparing' }
DataSeriesTest >> testCloseToDifferentNames [

	| firstSeries secondSeries |

	firstSeries := DataSeries withKeys: #(a b c) values: #(1 0.1 2) name: 'A'.
	secondSeries := DataSeries withKeys: #(a b c) values: #(1 0.10000001 2) name: 'B'.

	self deny: (firstSeries closeTo: secondSeries)
]

{ #category : #'tests - comparing' }
DataSeriesTest >> testCloseToDifferentValues [

	| firstSeries secondSeries |

	firstSeries := DataSeries withKeys: #(a b c) values: #(1 0.1 2) name: 'A'.
	secondSeries := DataSeries withKeys: #(a b c) values: #(1 3.10000001 2) name: 'A'.

	self deny: (firstSeries closeTo: secondSeries)
]

{ #category : #'tests - enumerating' }
DataSeriesTest >> testCollect [

	| actual expected |

	actual := series collect: [ :each |
		each / 10 ].

	expected := DataSeries
		withKeys: keyArray
		values: { 3/10 . 7/10 . 3/5 . 2 . 4/5 . 9/10 . 4/5 . 1 . 3/2 . 13/10 . 8/5 }
		name: 'ExampleSeries'.

	self assert: actual equals: expected
]

{ #category : #'tests - enumerating' }
DataSeriesTest >> testCollectWithNotNils [

	| actual expected |

	series := DataSeries
		withKeys: #(a b c d e f g h i j k)
		values: #(nil 7 6 nil 8 9 8 10 nil 13 16)
		name: 'ExampleSeries'.

	actual := series collectWithNotNils: [ :each |
		each / 10 ].

	expected := DataSeries
		withKeys: keyArray
		values: { nil . 7/10 . 3/5 . nil . 4/5 . 9/10 . 4/5 . 1 . nil . 13/10 . 8/5 }
		name: 'ExampleSeries'.

	self assert: actual equals: expected
]

{ #category : #'tests - copying' }
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

	self assert: seriesCopy equals: expectedCopyAfterChange
]

{ #category : #'tests - copying' }
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

	self assert: original equals: expectedOriginalAfterChange
]

{ #category : #'tests - creation' }
DataSeriesTest >> testCreateDataSeriesAsDataSeries [

	| dataSeries |
	dataSeries := #(a b c) asDataSeries.

	self assert: dataSeries size equals: 3.
	self assert: dataSeries asArray equals: #(a b c).
	self assert: dataSeries keys equals: #(1 2 3).
	self assert: dataSeries name equals: '(no name)'
]

{ #category : #'tests - creation' }
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
	self assert: dataSeries name equals: '(no name)'
]

{ #category : #'tests - creation' }
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
	self assert: dataSeries name equals: name
]

{ #category : #'tests - creation' }
DataSeriesTest >> testCreateDataSeriesWithValues [

	| values dataSeries |

	values := #(a b c).
	dataSeries := DataSeries withValues: values.

	self assert: dataSeries size equals: 3.
	self assert: dataSeries asArray equals: values.
	self assert: dataSeries keys equals: #(1 2 3).
	self assert: dataSeries name equals: '(no name)'
]

{ #category : #'tests - creation' }
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
	self assert: dataSeries name equals: name
]

{ #category : #'tests - creation' }
DataSeriesTest >> testCreateEmptyDataSeries [

	| dataSeries |
	dataSeries := DataSeries new.

	self assert: dataSeries size equals: 0.
	self assert: dataSeries asArray equals: #().
	self assert: dataSeries keys equals: #().
	self assert: dataSeries name equals: '(no name)'
]

{ #category : #'tests - enumerating' }
DataSeriesTest >> testDetect [

	| expected actual |

	expected := 7.
	actual := series detect: [ :x | x > 5 ].
	self assert: actual equals: expected
]

{ #category : #'tests - enumerating' }
DataSeriesTest >> testDetectIfNone [

	| expected actual |

	expected := 'not found'.
	actual := series detect: [ :x | x > 100 ] ifNone: [ 'not found' ].
	self assert: actual equals: expected
]

{ #category : #'tests - enumerating' }
DataSeriesTest >> testDetectNotFound [

	self
		should: [ series detect: [ :x | x > 100 ] ]
		raise: NotFound
]

{ #category : #'tests - enumerating' }
DataSeriesTest >> testDo [

	| sum |
	sum := 0.

	series do: [ :each |
		sum := sum + each ].

	self assert: sum equals: 115
]

{ #category : #'tests - accessing' }
DataSeriesTest >> testEighth [

	self assert: series eighth equals: 10
]

{ #category : #'tests - comparing' }
DataSeriesTest >> testEquality [

	| firstSeries secondSeries |

	firstSeries := DataSeries withKeys: #(a b c) values: #(1 0.1 'a') name: 'A'.
	secondSeries := DataSeries withKeys: #(a b c) values: #(1 0.1 'a') name: 'A'.

	self assert: firstSeries equals: secondSeries
]

{ #category : #'tests - accessing' }
DataSeriesTest >> testFifth [

	self assert: series fifth equals: 8
]

{ #category : #'tests - accessing' }
DataSeriesTest >> testFirst [

	self assert: series first equals: 3
]

{ #category : #'tests - accessing' }
DataSeriesTest >> testFourth [

	self assert: series fourth equals: 20
]

{ #category : #'tests - grouping' }
DataSeriesTest >> testGroupByAggregateUsing [
	| firstSeries secondSeries expected actual |

	firstSeries := DataSeries withValues: #(1 10 2 1 5) name: #salary.
	secondSeries := DataSeries withValues: #(Male Female Male Male Female) name: #sex.

	expected := DataSeries
		withKeys: #(Female Male)
		values: #(15 4)
		name: #salary.

	actual := firstSeries groupBy: secondSeries aggregateUsing: #sum.
	self assert: actual equals: expected
]

{ #category : #'tests - grouping' }
DataSeriesTest >> testGroupByAggregateUsingAs [
	| firstSeries secondSeries expected actual |

	firstSeries := DataSeries withValues: #(1 10 2 1 5) name: #salary.
	secondSeries := DataSeries withValues: #(Male Female Male Male Female) name: #sex.

	expected := DataSeries
		withKeys: #(Female Male)
		values: #(15 4)
		name: #totalSalary.

	actual := firstSeries groupBy: secondSeries aggregateUsing: #sum as: #totalSalary.
	self assert: actual equals: expected
]

{ #category : #'tests - grouping' }
DataSeriesTest >> testGroupByAggregateUsingAsSizeMismatch [
	| firstSeries secondSeries |

	firstSeries := DataSeries withValues: #(1 10 2 1) name: #salary.
	secondSeries := DataSeries withValues: #(Male Female Male Male Female) name: #sex.

	self
		should: [ firstSeries groupBy: secondSeries aggregateUsing: #sum as: #totalSalary ]
		raise: SizeMismatch
]

{ #category : #'tests - grouping' }
DataSeriesTest >> testGroupByAggregateUsingSizeMismatch [
	| firstSeries secondSeries |

	firstSeries := DataSeries withValues: #(1 10 2 1 5 100) name: #salary.
	secondSeries := DataSeries withValues: #(Male Female Male Male Female) name: #sex.

	self
		should: [ firstSeries groupBy: secondSeries aggregateUsing: #sum ]
		raise: SizeMismatch
]

{ #category : #'tests - grouping' }
DataSeriesTest >> testGroupByBins [

	| actual expected |
	actual := series groupByBins: { 0 . 5 . 10 . 15 . Float infinity }.
	expected := DataSeries withKeys: keyArray values: #( 1 2 2 4 2 2 2 2 3 3 4 ) name: 'ExampleSeries'.
	self assert: actual equals: expected
]

{ #category : #'tests - grouping' }
DataSeriesTest >> testGroupByBinsLabelled [

	| actual expected |
	actual := series
		          groupByBins: { 0 . 5 . 10 . 15 . Float infinity }
		          labelled: #( 0 5 10 15 ).
	expected := DataSeries withKeys: keyArray values: #( 0 5 5 15 5 5 5 5 10 10 15 ) name: 'ExampleSeries'.
	self assert: actual equals: expected
]

{ #category : #'tests - grouping' }
DataSeriesTest >> testGroupByBinsLabelledWithSizeProblem [

	self
		should: [
			series
				groupByBins: { 0 . 5 . 10 . 15 . Float infinity }
				labelled: #( 0 5 10 ) ]
		raise: SizeMismatch
]

{ #category : #'tests - grouping' }
DataSeriesTest >> testGroupByUniqueValuesAndAggregateUsing [

	series := DataSeries withValues: #( Male Female Male Male Female ) name: #sex.

	self assert: (series groupByUniqueValuesAndAggregateUsing: #size) equals: (DataSeries withKeys: #( #Female #Male ) values: #( 2 3 ) name: #sex)
]

{ #category : #'tests - missing values' }
DataSeriesTest >> testHasNil [
	| numbers |
	numbers := #(1 2 nil 3 4) asDataSeries.
	self assert: numbers hasNil
]

{ #category : #'tests - missing values' }
DataSeriesTest >> testHasNilFalse [
	| numbers |
	numbers := #(1 2 3 4) asDataSeries.
	self deny: numbers hasNil
]

{ #category : #'tests - head/tail' }
DataSeriesTest >> testHead [
	| expected actual |

	expected := DataSeries
		withKeys: #(a b c d e)
		values: #(3 7 6 20 8)
		name: series name.

	actual := series head.
	self assert: actual equals: expected
]

{ #category : #'tests - head/tail' }
DataSeriesTest >> testHeadN [
	| expected actual |

	expected := DataSeries
		withKeys: #(a b)
		values: #(3 7)
		name: series name.

	actual := series head: 2.
	self assert: actual equals: expected
]

{ #category : #'tests - comparing' }
DataSeriesTest >> testInequality [

	| a b |

	a := #(1 0.1 'a') asDataSeries.
	b := #(2 0.2 'b') asDataSeries.

	a name: 'A'.
	b name: 'B'.

	self assert: (a ~= b)
]

{ #category : #'tests - comparing' }
DataSeriesTest >> testInequalityDifferentKeys [

	| firstSeries secondSeries |

	firstSeries := DataSeries withKeys: #(a b c) values: #(1 0.1 'a') name: 'A'.
	secondSeries := DataSeries withKeys: #(x y z) values: #(1 0.1 'a') name: 'A'.

	self assert: (firstSeries ~= secondSeries)
]

{ #category : #'tests - comparing' }
DataSeriesTest >> testInequalityDifferentNames [

	| firstSeries secondSeries |

	firstSeries := DataSeries withKeys: #(a b c) values: #(1 0.1 'a') name: 'A'.
	secondSeries := DataSeries withKeys: #(a b c) values: #(1 0.1 'a') name: 'B'.

	self assert: (firstSeries ~= secondSeries)
]

{ #category : #'tests - comparing' }
DataSeriesTest >> testInequalityDifferentValues [

	| firstSeries secondSeries |

	firstSeries := DataSeries withKeys: #(a b c) values: #(1 0.1 'a') name: 'A'.
	secondSeries := DataSeries withKeys: #(a b c) values: #(1 0.2 'a') name: 'A'.

	self assert: (firstSeries ~= secondSeries)
]

{ #category : #'tests - enumerating' }
DataSeriesTest >> testInjectInto [

	| expected actual |

	expected := 115.
	actual := series inject: 0 into: [ :sum :x | sum + x ].
	self assert: actual equals: expected
]

{ #category : #'tests - testing' }
DataSeriesTest >> testIsNumerical [

	self assert: #( 1 2 3 ) asDataSeries isNumerical.
	self deny: #( 1 2 '3' ) asDataSeries isNumerical
]

{ #category : #'tests - testing' }
DataSeriesTest >> testIsNumericalWithNils [

	self assert: #( 1 nil 3 ) asDataSeries isNumerical
]

{ #category : #'tests - accessing' }
DataSeriesTest >> testLast [

	self assert: series last equals: 16
]

{ #category : #'tests - math functions' }
DataSeriesTest >> testMathAbs [

	| a b |

	a := { 1 . -2 . 3 . -4 } asDataSeries.
	b := { 1 . 2 . 3 . 4 } asDataSeries.

	self assert: a abs closeTo: b
]

{ #category : #'tests - math functions' }
DataSeriesTest >> testMathCorrelationWith [
	| age income correlationCoefficient |

	age := #(20 30 40 50) asDataSeries.
	income := #(1500 3000 5000 7500) asDataSeries.

	correlationCoefficient := age correlationWith: income.
	self assert: correlationCoefficient closeTo: 0.99380799
]

{ #category : #'tests - math functions' }
DataSeriesTest >> testMathCos [

	| a b pi |

	pi := Float pi.
	a := { 0 . pi . pi/2 . pi/4 . pi/3 } asDataSeries.
	b := { 1.0 . -1.0 . 0.0 . 1/2 sqrt . 0.5 } asDataSeries.

	self assert: a cos closeTo: b
]

{ #category : #'tests - math functions' }
DataSeriesTest >> testMathExp [

	| a b |

	a := { 1 . 2 . 3 . 4 } asDataSeries.
	b := { 2.71828 . 7.38906 . 20.08554 . 54.59815 } asDataSeries.

	self assert: a exp closeTo: b
]

{ #category : #'tests - math functions' }
DataSeriesTest >> testMathLn [

	| a b |

	a := { 1 . 2 . 3 . 4 } asDataSeries.
	b := { 0 . 0.69315 . 1.09861 . 1.38629 } asDataSeries.

	self assert: a ln closeTo: b
]

{ #category : #'tests - math functions' }
DataSeriesTest >> testMathLog [

	| a b |

	a := { 1 . 2 . 3 . 4 } asDataSeries.
	b := { 0.0 . 0.30103 . 0.47712 . 0.60205 } asDataSeries.

	self assert: a log closeTo: b
]

{ #category : #'tests - math functions' }
DataSeriesTest >> testMathLog2 [

	| a b |

	a := { 1 . 2 . 3 . 4 } asDataSeries.
	b := { 0 . 1 . 1.58496 . 2 } asDataSeries.

	self assert: (a log: 2) closeTo: b
]

{ #category : #'tests - math functions' }
DataSeriesTest >> testMathPowerScalar [

	| a b |

	a := #(1 2 3) asDataSeries.
	b := #(1 4 9) asDataSeries.

	self assert: a ** 2 equals: b
]

{ #category : #'tests - math functions' }
DataSeriesTest >> testMathSin [

	| a b pi |

	pi := Float pi.
	a := { 0 . pi . pi/2 . pi/4 . pi/6 } asDataSeries.
	b := { 0.0 . 0.0 . 1.0 . 1/2 sqrt . 0.5 } asDataSeries.

	self assert: a sin closeTo: b
]

{ #category : #'tests - math functions' }
DataSeriesTest >> testMathSqrt [

	| a b |

	a := { 1 . 2 . 3 . 4 } asDataSeries.
	b := { 1 . 1.41421 . 1.73205 . 2 } asDataSeries.

	self assert: a sqrt closeTo: b
]

{ #category : #'tests - math functions' }
DataSeriesTest >> testMathTan [

	| a b |

	a := { 1 . 2 . 3 . 4 } asDataSeries.
	b := { 1.55741 . -2.18504 . -0.14255 . 1.15782 } asDataSeries.

	self assert: a tan closeTo: b
]

{ #category : #'tests - creation' }
DataSeriesTest >> testNewFrom [

	| dataseries |

	dataseries := DataSeries newFrom: (series associations).
	dataseries name: 'ExampleSeries'.

	self assert: dataseries equals: series
]

{ #category : #'tests - accessing' }
DataSeriesTest >> testNinth [

	self assert: series ninth equals: 15
]

{ #category : #'tests - arithmetic' }
DataSeriesTest >> testNumericalCanBeMadeCategorical [

	| numericalSeries |
	numericalSeries := {42 . -1.0 . 4/3} asDataSeries.
	self assert: numericalSeries makeCategorical isCategorical
]

{ #category : #'tests - arithmetic' }
DataSeriesTest >> testNumericalCanBeMadeNumerical [

	| numericalSeries |
	numericalSeries := {42 . -1.0 . 4/3} asDataSeries.
	self assert: numericalSeries makeNumerical isNumerical
]

{ #category : #'tests - arithmetic' }
DataSeriesTest >> testNumericalIsNotCategorical [

	| numericalSeries |
	numericalSeries := {42 . -1.0 . 4/3} asDataSeries.
	self deny: numericalSeries isCategorical
]

{ #category : #'tests - arithmetic' }
DataSeriesTest >> testNumericalIsNumerical [

	| numericalSeries |
	numericalSeries := {42 . -1.0 . 4/3} asDataSeries.
	self assert: numericalSeries isNumerical
]

{ #category : #'tests - enumerating' }
DataSeriesTest >> testReject [

	| expected actual |

	expected := DataSeries
		withKeys: #(a b c e f g)
		values: #(3 7 6 8 9 8)
		name: 'ExampleSeries'.

	actual := series reject: [ :x | x >= 10 ].
	self assert: actual equals: expected
]

{ #category : #'tests - removing' }
DataSeriesTest >> testRemoveAt [

	| expected |

	expected := DataSeries
		withKeys: (keyArray copyWithout: #c)
		values: #(3 7 20 8 9 8 10 15 13 16)
		name: 'ExampleSeries'.

	series removeAt: #c.

	self assert: series equals: expected
]

{ #category : #'tests - removing' }
DataSeriesTest >> testRemoveAtIndex [

	| expected |

	expected := DataSeries
		withKeys: (keyArray copyWithout: #c)
		values: #(3 7 20 8 9 8 10 15 13 16)
		name: 'ExampleSeries'.

	series removeAtIndex: 3.

	self assert: series equals: expected
]

{ #category : #'tests - removing' }
DataSeriesTest >> testRemoveNils [

	| expected |

	series := DataSeries withKeys: #(1 2 'a' 3) values: #(nil 4.2 'b' nil).
	expected := DataSeries withKeys: #(2 'a') values: #(4.2 'b').

	self assert: series removeNils equals: expected
]

{ #category : #'tests - removing' }
DataSeriesTest >> testRemoveNilsOnNamedSeries [

	| expected |

	series := DataSeries withKeys: #(1 2 'a' 3) values: #(nil 4.2 'b' nil) name: 'A'.
	expected := DataSeries withKeys: #(2 'a') values: #(4.2 'b') name: 'A'.

	self assert: series removeNils equals: expected
]

{ #category : #'tests - missing values' }
DataSeriesTest >> testReplaceNilsWith [

	| expected |
	series := DataSeries
		withKeys: keyArray
		values: #(3 7 nil 20 8 9 8 nil 15 nil 16)
		name: 'ExampleSeries'.

	expected := DataSeries
		withKeys: keyArray
		values: #(3 7 0 20 8 9 8 0 15 0 16)
		name: 'ExampleSeries'.

	self assert: (series replaceNilsWith: 0.0) equals: expected
]

{ #category : #'tests - missing values' }
DataSeriesTest >> testReplaceNilsWithAverage [

	| expected |
	series := DataSeries
		withKeys: keyArray
		values: #(3 7 nil 20 8 9 8 nil 15 nil 16)
		name: 'ExampleSeries'.

	expected := DataSeries
		withKeys: keyArray
		values: {3 . 7 . 43/4 . 20 . 8 . 9 . 8 . 43/4 . 15 . 43/4 . 16}
		name: 'ExampleSeries'.

	self assert: series replaceNilsWithAverage equals: expected
]

{ #category : #'tests - missing values' }
DataSeriesTest >> testReplaceNilsWithFloat [

	| expected |
	series := DataSeries
		withKeys: keyArray
		values: #(3 7 nil 20 8 9 8 nil 15 nil 16)
		name: 'ExampleSeries'.

	expected := DataSeries
		withKeys: keyArray
		values: #(3 7 3.14 20 8 9 8 3.14 15 3.14 16)
		name: 'ExampleSeries'.

	self assert: (series replaceNilsWith: 3.14) equals: expected
]

{ #category : #'tests - missing values' }
DataSeriesTest >> testReplaceNilsWithMedian [

	| expected |
	series := DataSeries
		withKeys: #(a b c d e f g h i j k l)
		values: #(1 3 7 nil 20 8 9 8 nil 15 nil 16)
		name: 'ExampleSeries'.

	expected := DataSeries
		withKeys: #(a b c d e f g h i j k l)
		values: #(1 3 7 8 20 8 9 8 8 15 8 16)
		name: 'ExampleSeries'.

	self assert: series replaceNilsWithMedian equals: expected
]

{ #category : #'tests - missing values' }
DataSeriesTest >> testReplaceNilsWithMode [

	| expected |
	series := DataSeries
		withKeys: keyArray
		values: #(3 7 nil 20 8 9 8 nil 15 nil 16)
		name: 'ExampleSeries'.

	expected := DataSeries
		withKeys: keyArray
		values: #(3 7 8 20 8 9 8 8 15 8 16)
		name: 'ExampleSeries'.

	self assert: series replaceNilsWithMode equals: expected
]

{ #category : #'tests - missing values' }
DataSeriesTest >> testReplaceNilsWithPreviousValue [

	| sampleSeries expected |
	sampleSeries := DataSeries
		                withKeys: keyArray
		                values: #( nil 3 nil 20 nil 9 0 nil 15 nil nil )
		                name: 'ExampleSeries'.
	expected := DataSeries
		            withKeys: keyArray
		            values: #( nil 3 3 20 20 9 0 0 15 15 15 )
		            name: 'ExampleSeries'.
	self
		assert: sampleSeries replaceNilsWithPreviousValue
		equals: expected
]

{ #category : #'tests - missing values' }
DataSeriesTest >> testReplaceNilsWithString [

	| expected |
	series := DataSeries
		withKeys: keyArray
		values: #(3 7 nil 20 8 9 8 nil 15 nil 16)
		name: 'ExampleSeries'.

	expected := DataSeries
		withKeys: keyArray
		values: #(3 7 'abc' 20 8 9 8 'abc' 15 'abc' 16)
		name: 'ExampleSeries'.

	self assert: (series replaceNilsWith: 'abc') equals: expected
]

{ #category : #'tests - missing values' }
DataSeriesTest >> testReplaceNilsWithZeros [

	| expected |
	series := DataSeries
		withKeys: keyArray
		values: #(3 7 nil 20 8 9 8 nil 15 nil 16)
		name: 'ExampleSeries'.

	expected := DataSeries
		withKeys: keyArray
		values: #(3 7 0 20 8 9 8 0 15 0 16)
		name: 'ExampleSeries'.

	self assert: (series replaceNilsWithZeros) equals: expected
]

{ #category : #'tests - accessing' }
DataSeriesTest >> testSecond [

	self assert: series second equals: 7
]

{ #category : #'tests - enumerating' }
DataSeriesTest >> testSelect [

	| expected actual |

	expected := DataSeries
		withKeys: #(a b c e f g)
		values: #(3 7 6 8 9 8)
		name: 'ExampleSeries'.

	actual := series select: [ :x | x < 10 ].
	self assert: actual equals: expected
]

{ #category : #'tests - accessing' }
DataSeriesTest >> testSeventh [

	self assert: series seventh equals: 8
]

{ #category : #'tests - accessing' }
DataSeriesTest >> testSixth [

	self assert: series sixth equals: 9
]

{ #category : #'tests - sorting' }
DataSeriesTest >> testSort [
	| expected |

	expected := DataSeries
		withKeys: #(a c b e g f h j i k d)
		values: #(3 6 7 8 8 9 10 13 15 16 20)
		name: series name.

	series sort.
	self assert: series equals: expected
]

{ #category : #'tests - sorting' }
DataSeriesTest >> testSortBlock [
	| expected |

	expected := DataSeries
		withKeys: #(k j i h d g f e c b a)
		values: #(16 13 15 10 20 8 9 8 6 7 3)
		name: series name.

	series sort: [ :a :b | a asString size > b asString size ].
	self assert: series equals: expected
]

{ #category : #'tests - sorting' }
DataSeriesTest >> testSortDescending [
	| expected |

	expected := DataSeries
		withKeys: #(d k i j h f g e b c a)
		values: #(20 16 15 13 10 9 8 8 7 6 3)
		name: series name.

	series sortDescending.
	self assert: series equals: expected
]

{ #category : #'tests - sorting' }
DataSeriesTest >> testSorted [
	| expected actual |

	expected := DataSeries
		withKeys: #(a c b e g f h j i k d)
		values: #(3 6 7 8 8 9 10 13 15 16 20)
		name: series name.

	actual := series sorted.
	self assert: actual equals: expected
]

{ #category : #'tests - sorting' }
DataSeriesTest >> testSortedBlock [
	| expected actual |

	expected := DataSeries
		withKeys: #(k j i h d g f e c b a)
		values: #(16 13 15 10 20 8 9 8 6 7 3)
		name: series name.

	actual := series sorted: [ :a :b | a asString size > b asString size ].
	self assert: actual equals: expected
]

{ #category : #'tests - sorting' }
DataSeriesTest >> testSortedBlockDoesNotChangeTheReceiver [
	| expected |

	expected := DataSeries
		withKeys: #(a b c d e f g h i j k)
		values: #(3 7 6 20 8 9 8 10 15 13 16)
		name: series name.

	series sorted: [ :a :b | a asString size > b asString size ].
	self assert: series equals: expected
]

{ #category : #'tests - sorting' }
DataSeriesTest >> testSortedDescending [
	| expected actual |

	expected := DataSeries
		withKeys: #(d k i j h f g e b c a)
		values: #(20 16 15 13 10 9 8 8 7 6 3)
		name: series name.

	actual := series sortedDescending.
	self assert: actual equals: expected
]

{ #category : #'tests - sorting' }
DataSeriesTest >> testSortedDescendingDoesNotChangeTheReceiver [
	| expected |

	expected := DataSeries
		withKeys: #(a b c d e f g h i j k)
		values: #(3 7 6 20 8 9 8 10 15 13 16)
		name: series name.

	series sortedDescending.
	self assert: series equals: expected
]

{ #category : #'tests - sorting' }
DataSeriesTest >> testSortedDoesNotChangeTheReceiver [
	| expected |

	expected := DataSeries
		withKeys: #(a b c d e f g h i j k)
		values: #(3 7 6 20 8 9 8 10 15 13 16)
		name: series name.

	series sorted.
	self assert: series equals: expected
]

{ #category : #'tests - statistics' }
DataSeriesTest >> testStatsAverage [

	self assert: series average equals: (115/11)
]

{ #category : #'tests - statistics' }
DataSeriesTest >> testStatsCumulativeSum [

	| seriesWithNils expected |

	seriesWithNils := DataSeries
		withKeys: #(a b c d e f g h i j k l)
		values: #(nil 3 4 7 nil 2 4 0 3 nil 2 9)
		name: 'numbers'.

	expected := DataSeries
		withKeys: #(a b c d e f g h i j k l)
		values: #(0 3 7 14 14 16 20 20 23 23 25 34)
		name: 'numbers'.

	self assert: seriesWithNils cumulativeSum equals: expected
]

{ #category : #'tests - statistics' }
DataSeriesTest >> testStatsFirstQuartile [

	self assert: series firstQuartile equals: 7
]

{ #category : #'tests - statistics' }
DataSeriesTest >> testStatsFourthQuartile [

	self assert: series fourthQuartile equals: 20
]

{ #category : #'tests - statistics' }
DataSeriesTest >> testStatsFourthQuartileEqualsMax [

	self assert: series fourthQuartile equals: series max
]

{ #category : #'tests - statistics' }
DataSeriesTest >> testStatsInterquartileRange [

	self assert: series interquartileRange equals: 8
]

{ #category : #'tests - statistics' }
DataSeriesTest >> testStatsMax [

	self assert: series max equals: 20
]

{ #category : #'tests - statistics' }
DataSeriesTest >> testStatsMedian [

	self assert: series median equals: 9
]

{ #category : #'tests - statistics' }
DataSeriesTest >> testStatsMin [

	self assert: series min equals: 3
]

{ #category : #'tests - statistics' }
DataSeriesTest >> testStatsMode [

	self assert: series mode equals: 8
]

{ #category : #'tests - statistics' }
DataSeriesTest >> testStatsQuantile [

	self assert: (series quantile: 0) equals: 3.
	self assert: (series quantile: 10) equals: 6.
	self assert: (series quantile: 25) equals: 7.
	self assert: (series quantile: 50) equals: 9.
	self assert: (series quantile: 75) equals: 15.
	self assert: (series quantile: 100) equals: 20
]

{ #category : #'tests - statistics' }
DataSeriesTest >> testStatsQuantileDoesNotModifyTheSeries [

	| copy |
	copy := series copy.
	series quantile: 5.
	self assert: series equals: copy
]

{ #category : #'tests - statistics' }
DataSeriesTest >> testStatsQuartile [

	self assert: (series quartile: 0) equals: 3.
	self assert: (series quartile: 1) equals: 7.
	self assert: (series quartile: 2) equals: 9.
	self assert: (series quartile: 3) equals: 15.
	self assert: (series quartile: 4) equals: 20
]

{ #category : #'tests - statistics' }
DataSeriesTest >> testStatsQuartileWithNil [
	series atIndex: 2 put: nil.
	self assert: (series quartile: 0) equals: 3.
	self assert: (series quartile: 1) equals: 8.
	self assert: (series quartile: 2) equals: 9.
	self assert: (series quartile: 3) equals: 15.
	self assert: (series quartile: 4) equals: 20
]

{ #category : #'tests - statistics' }
DataSeriesTest >> testStatsRange [

	self assert: series range equals: 17
]

{ #category : #'tests - statistics' }
DataSeriesTest >> testStatsSecondQuartile [

	self assert: series secondQuartile equals: 9
]

{ #category : #'tests - statistics' }
DataSeriesTest >> testStatsSecondQuartileEqualsMedian [

	self assert: series secondQuartile equals: series median
]

{ #category : #'tests - statistics' }
DataSeriesTest >> testStatsStdev [

	self assert: series stdev closeTo: 5.00727
]

{ #category : #'tests - statistics' }
DataSeriesTest >> testStatsSummary [
	| expected actual |

	expected := DataSeries
		withKeys: #(Min '1st Qu.' Median Average '3rd Qu.' Max)
		values: { 3 . 7 . 9 . (115 / 11) . 15 . 20 }
		name: series name.

	actual := series summary.

	self assert: actual equals: expected
]

{ #category : #'tests - statistics' }
DataSeriesTest >> testStatsThirdQuartile [

	self assert: series thirdQuartile equals: 15
]

{ #category : #'tests - statistics' }
DataSeriesTest >> testStatsVariance [

	self assert: series variance closeTo: 25.07273
]

{ #category : #'tests - statistics' }
DataSeriesTest >> testStatsZerothQuartile [

	self assert: series zerothQuartile equals: 3
]

{ #category : #'tests - statistics' }
DataSeriesTest >> testStatsZerothQuartileEqualsMin [

	self assert: series zerothQuartile equals: series min
]

{ #category : #'tests - arithmetic' }
DataSeriesTest >> testSum [

	self assert: #( 1 2 3 4 ) asDataSeries sum equals: 10
]

{ #category : #'tests - arithmetic' }
DataSeriesTest >> testSumWithNils [

	self assert: #( 1 2 nil 4 ) asDataSeries sum equals: 7.
	self assert: #( nil nil nil ) asDataSeries sum equals: 0
]

{ #category : #'tests - head/tail' }
DataSeriesTest >> testTail [
	| expected actual |

	expected := DataSeries
		withKeys: #(g h i j k)
		values: #(8 10 15 13 16)
		name: series name.

	actual := series tail.
	self assert: actual equals: expected
]

{ #category : #'tests - head/tail' }
DataSeriesTest >> testTailN [
	| expected actual |

	expected := DataSeries
		withKeys: #(j k)
		values: #(13 16)
		name: series name.

	actual := series tail: 2.
	self assert: actual equals: expected
]

{ #category : #'tests - accessing' }
DataSeriesTest >> testThird [

	self assert: series third equals: 6
]

{ #category : #'tests - enumerating' }
DataSeriesTest >> testWithIndexCollect [

	| actual expected |

	actual := series withIndexCollect: [ :each :i |
		each / 10 + i ].

	expected := DataSeries
		withKeys: keyArray
		values: {(13/10). (27/10). (18/5). 6. (29/5). (69/10). (39/5). 9. (21/2). (113/10). (63/5)}
		name: 'ExampleSeries'.

	self assert: actual equals: expected
]

{ #category : #'tests - enumerating' }
DataSeriesTest >> testWithIndexDetect [

	| expected actual |

	expected := 6.
	actual := series withIndexDetect: [ :x :i | (x > 5) and: (i odd) ].
	self assert: actual equals: expected
]

{ #category : #'tests - enumerating' }
DataSeriesTest >> testWithIndexDetectIfNone [

	| expected actual |

	expected := 'not found'.
	actual := series withIndexDetect: [ :x :i | i > 100 ] ifNone: [ 'not found' ].
	self assert: actual equals: expected
]

{ #category : #'tests - enumerating' }
DataSeriesTest >> testWithIndexDetectNotFound [

	self
		should: [ series withIndexDetect: [ :x :i | i > 100 ] ]
		raise: NotFound
]

{ #category : #'tests - enumerating' }
DataSeriesTest >> testWithIndexDo [

	| sum |
	sum := 0.

	series withIndexDo: [ :each :i |
		sum := sum + (each / i) ].

	self assert: sum equals: (108173/4620)
]

{ #category : #'tests - enumerating' }
DataSeriesTest >> testWithIndexReject [

	| expected actual |

	expected := DataSeries
		withKeys: #(a c e g)
		values: #(3 6 8 8)
		name: 'ExampleSeries'.

	actual := series withIndexReject: [ :x :i | x >= 10 or: i even ].
	self assert: actual equals: expected
]

{ #category : #'tests - enumerating' }
DataSeriesTest >> testWithIndexSelect [

	| expected actual |

	expected := DataSeries
		withKeys: #(a c e g)
		values: #(3 6 8 8)
		name: 'ExampleSeries'.

	actual := series withIndexSelect: [ :x :i | x < 10 and: i odd ].
	self assert: actual equals: expected
]

{ #category : #'tests - enumerating' }
DataSeriesTest >> testWithKeyCollect [

	| actual expected |

	actual := series withKeyCollect: [ :each :key |
		each / 10 + (keyArray indexOf: key) ].

	expected := DataSeries
		withKeys: keyArray
		values: {(13/10). (27/10). (18/5). 6. (29/5). (69/10). (39/5). 9. (21/2). (113/10). (63/5)}
		name: 'ExampleSeries'.

	self assert: actual equals: expected
]

{ #category : #'tests - enumerating' }
DataSeriesTest >> testWithKeyDetect [

	| expected actual |

	expected := 6.
	actual := series withKeyDetect: [ :x :k | x > 5 and: (k = #c) ].
	self assert: actual equals: expected
]

{ #category : #'tests - enumerating' }
DataSeriesTest >> testWithKeyDetectIfNone [

	| expected actual |

	expected := 'not found'.
	actual := series withKeyDetect: [ :x :k | x > 5 and: (k = #NoSuchKey) ] ifNone: [ 'not found' ].
	self assert: actual equals: expected
]

{ #category : #'tests - enumerating' }
DataSeriesTest >> testWithKeyDetectNotFound [

	self
		should: [ series withKeyDetect: [ :x :k | x > 5 and: (k = #NoSuchKey) ] ]
		raise: NotFound
]

{ #category : #'tests - enumerating' }
DataSeriesTest >> testWithKeyDo [

	| sum |
	sum := 0.

	series withKeyDo: [ :each :key |
		sum := sum + (each / (keyArray indexOf: key)) ].

	self assert: sum equals: (108173/4620)
]

{ #category : #'tests - enumerating' }
DataSeriesTest >> testWithKeyReject [

	| expected actual |

	expected := DataSeries
		withKeys: #(a c g)
		values: #(3 6 8)
		name: 'ExampleSeries'.

	actual := series withKeyReject: [ :x :k | x >= 10 or: (#(a c g) includes: k) not ].
	self assert: actual equals: expected
]

{ #category : #'tests - enumerating' }
DataSeriesTest >> testWithKeySelect [

	| expected actual |

	expected := DataSeries
		withKeys: #(a c g)
		values: #(3 6 8)
		name: 'ExampleSeries'.

	actual := series withKeySelect: [ :x :k | x < 10 and: (#(a c g) includes: k) ].
	self assert: actual equals: expected
]
