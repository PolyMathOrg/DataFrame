tests
testAddElementwise

	| a b c |
	
	a := #(1 2 3) asDataSeries.
	b := #(3 4 5) asDataSeries.
	c := #(4 6 8) asDataSeries.
	
	self assert: a + b equals: c.