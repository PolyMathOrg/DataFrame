tests
testMultiplyScalar

	| a b |
	
	a := #(1 2 3) asDataSeries.
	b := #(2 4 6) asDataSeries.
	
	self assert: 2 * a equals: b.
	self assert: a * 2 equals: b.