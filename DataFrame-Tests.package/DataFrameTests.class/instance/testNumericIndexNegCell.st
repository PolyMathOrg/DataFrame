tests
testNumericIndexNegCell

	| df |
	
	df := DataFrame rows: #(
		(1 2 3 4)
		(5 6 7 8)).
	
	self assert: (df at: 0 at: 1) equals: 5.
	self assert: (df at: 2 at: -1) equals: 7.
	self assert: (df at: -5 at: -6) equals: 2.