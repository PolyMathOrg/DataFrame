tests
testSubtractElementwise

	| a b c d |
	
	a := #(1 2 3) asDataSeries.
	b := #(3 6 8) asDataSeries.
	c := #(-2 -4 -5) asDataSeries.
	d := #(2 4 5) asDataSeries.
	
	self assert: a - b equals: c.
	self assert: b - a equals: d.