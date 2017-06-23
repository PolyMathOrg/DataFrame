tests
testCrossTabulation

	| df expected |
	
	df := DataFrame rows: #(
		(Male Young)
		(Female Old)
		(Female Young)
		(Female Young)
		(Male Old)).
	df columnNames: #(Gender Age).
	
	expected := DataFrame rows:
		#((1 1)(2 1)).
		
	expected rowNames: #(Male Female).
	expected columnNames: #(Young Old).	
	
	self assert: (df crossTabulate: #Gender with: #Age) equals: expected.