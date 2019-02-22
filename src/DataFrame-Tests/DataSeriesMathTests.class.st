Class {
	#name : #DataSeriesMathTests,
	#superclass : #TestCase,
	#category : #'DataFrame-Tests'
}

{ #category : #tests }
DataSeriesMathTests >> testAddElementwise [

	| a b c |
	
	a := #(1 2 3) asDataSeries.
	b := #(3 4 5) asDataSeries.
	c := #(4 6 8) asDataSeries.
	
	self assert: a + b equals: c.
]

{ #category : #tests }
DataSeriesMathTests >> testCos [

	| a b pi |
	
	pi := Float pi.
	a := { 0 . pi . pi/2 . pi/4 . pi/3 } asDataSeries.
	b := { 1.0 . -1.0 . 0.0 . 1/2 sqrt . 0.5 } asDataSeries.
	
	self assert: a cos closeTo: b.
]

{ #category : #tests }
DataSeriesMathTests >> testDivideByScalar [

	| a b |
	
	a := #(1 2 3) asDataSeries.
	b := #(0.5 1 1.5) asDataSeries.
	
	self assert: a / 2 equals: b.
]

{ #category : #tests }
DataSeriesMathTests >> testMultiplyScalar [

	| a b |
	
	a := #(1 2 3) asDataSeries.
	b := #(2 4 6) asDataSeries.
	
	self assert: 2 * a equals: b.
	self assert: a * 2 equals: b.
]

{ #category : #tests }
DataSeriesMathTests >> testPowerScalar [

	| a b |
	
	a := #(1 2 3) asDataSeries.
	b := #(1 4 9) asDataSeries.
	
	self assert: a ** 2 equals: b.
]

{ #category : #tests }
DataSeriesMathTests >> testSin [

	| a b pi |
	
	pi := Float pi.
	a := { 0 . pi . pi/2 . pi/4 . pi/6 } asDataSeries.
	b := { 0.0 . 0.0 . 1.0 . 1/2 sqrt . 0.5 } asDataSeries.
	
	self assert: a sin closeTo: b.
]

{ #category : #tests }
DataSeriesMathTests >> testSubtractElementwise [

	| a b c d |
	
	a := #(1 2 3) asDataSeries.
	b := #(3 6 8) asDataSeries.
	c := #(-2 -4 -5) asDataSeries.
	d := #(2 4 5) asDataSeries.
	
	self assert: a - b equals: c.
	self assert: b - a equals: d.
]
