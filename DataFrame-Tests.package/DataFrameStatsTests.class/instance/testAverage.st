tests
testAverage

	| df expected | 
	
	df := DataFrame columns: #(
		(-1 2 1 4 3 0 1 2)
		(-3 -3 -2 6 4 1 2 3)).
	df columnNames: #(col1 col2).
	
	expected := #(0.5 1) asDataSeries.
	expected keys: #(col1 col2).
	
	self assert: df average equals: expected.