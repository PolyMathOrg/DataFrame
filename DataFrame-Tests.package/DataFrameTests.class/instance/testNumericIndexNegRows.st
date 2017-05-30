tests
testNumericIndexNegRows

	| df |
	
	df := DataFrame rows: #(
		(1 2)
		(3 4)
		(5 6)
		(7 8)).
		
	self assert: df class equals: DataFrame.
	
	self assert: (df rows: #(0 -1))
		equals: (DataFrame rows: #((3 4)(7 8))).
		
	self assert: (df rows: #(1 -1))
		equals: (DataFrame rows: #((1 3)(5 7))).
		
	self assert: (df rows: #(2 -2))
		equals: (DataFrame rows: #((2 2)(6 6))).