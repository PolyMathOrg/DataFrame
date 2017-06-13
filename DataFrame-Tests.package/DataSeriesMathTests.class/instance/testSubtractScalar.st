tests
testSubtractScalar

	| a b c |
	
	a := #(1 2 3) asDataSeries.
	b := #(-4 -3 -2) asDataSeries.
	c := #(4 3 2) asDataSeries.
	
	self assert: a - 5 equals: b.
	self assert: 5 - a equals: c.