tests
testAddScalar

	| a b |
	
	a := #(1 2 3) asDataSeries.
	b := #(6 7 8) asDataSeries.
	
	self assert: a + 5 equals: b.
	self assert: 5 + a equals: b.