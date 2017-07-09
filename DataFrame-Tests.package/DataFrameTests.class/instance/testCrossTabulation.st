tests
testCrossTabulation

	| dataFrame expected |
	
	dataFrame := DataFrame fromRows: #(
		(Male Young)
		(Female Old)
		(Female Young)
		(Female Young)
		(Male Old)).
	dataFrame columnNames: #(Gender Age).
	
	expected := DataFrame fromRows:
		#((1 1)(2 1)).
		
	expected rowNames: #(Male Female).
	expected columnNames: #(Young Old).	
	
	self assert: (dataFrame crossTabulate: #Gender with: #Age) equals: expected.