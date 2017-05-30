tests
testNumericIndexNegRow

	| df |
	
	df := DataFrame rows: #(
		(1 2 3 4)
		(5 6 7 8)).
	
	self assert: (df rowAt: 0) equals: #(5 6 7 8).
	self assert: (df rowAt: -1) equals: #(1 2 3 4).
	self assert: (df rowAt: -3) equals: #(1 2 3 4).