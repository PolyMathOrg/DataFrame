tests
testPowerScalar

	| a b |
	
	a := #(1 2 3) asDataSeries.
	b := #(1 4 9) asDataSeries.
	
	self assert: a ** 2 equals: b.