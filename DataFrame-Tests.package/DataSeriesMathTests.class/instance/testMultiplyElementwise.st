tests
testMultiplyElementwise

	| a b c |
	
	a := #(1 2 3) asDataSeries.
	b := #(2 3 4) asDataSeries.
	c := #(2 6 12) asDataSeries.
	
	self assert: a * b equals: c.