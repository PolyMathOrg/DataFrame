tests
testDivisorOfScalar

	| a b |
	
	a := #(1 2 3) asDataSeries.
	b := {1 . 1/2 . 1/3} asDataSeries.
	
	self assert: 1 / a equals: b.