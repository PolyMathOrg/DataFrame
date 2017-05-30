tests
testNumericIndexNegColumn

	| df |
	
	df := DataFrame rows: #(
		(1 2 3 4)
		(5 6 7 8)).
	
	self assert: (df columnAt: 0) equals: #(4 8).
	self assert: (df columnAt: -1) equals: #(3 7).
	self assert: (df columnAt: -6) equals: #(2 6).