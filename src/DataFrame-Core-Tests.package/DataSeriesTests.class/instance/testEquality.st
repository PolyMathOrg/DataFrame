tests
testEquality

	| a b |
	
	a := #(1 0.1 'a') asDataSeries.
	b := #(1 0.1 'a') asDataSeries.
	
	a name: 'A'.
	b name: 'B'.
	
	self assert: a equals: b.