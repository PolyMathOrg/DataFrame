tests
testMin

	| df expected | 
	df := DataFrame columns: #((1 2)(4 3)).
	df columnNames: #(col1 col2).
	
	expected := #(1 3) asDataSeries.
	expected keys: #(col1 col2).
	
	self assert: df min equals: expected.