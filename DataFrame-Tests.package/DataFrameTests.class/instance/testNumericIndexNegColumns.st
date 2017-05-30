tests
testNumericIndexNegColumns

	| df |
	
	df := DataFrame rows: #(
		(1 2 3 4)
		(5 6 7 8)).
		
	"self assert: df class equals: #DataFrame."
	
	self assert: (df columns: #(0 -1))
		equals: (DataFrame rows: #((4 3)(8 7))).
		
	self assert: (df columns: #(1 -1))
		equals: (DataFrame rows: #((1 3)(5 7))).
		
	self assert: (df columns: #(2 -2))
		equals: (DataFrame rows: #((2 2)(6 6))).