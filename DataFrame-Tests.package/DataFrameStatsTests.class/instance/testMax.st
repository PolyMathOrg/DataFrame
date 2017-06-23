tests
testMax

	| df expected | 
	df := DataFrame columns: #((1 2)(4 3)).
	df columnNames: #(col1 col2).
	
	expected := #(2 4) asDataSeries.
	expected keys: #(col1 col2).
	
	self assert: df max equals: expected.