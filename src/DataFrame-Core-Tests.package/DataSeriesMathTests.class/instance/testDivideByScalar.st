tests
testDivideByScalar

	| a b |
	
	a := #(1 2 3) asDataSeries.
	b := #(0.5 1 1.5) asDataSeries.
	
	self assert: a / 2 equals: b.