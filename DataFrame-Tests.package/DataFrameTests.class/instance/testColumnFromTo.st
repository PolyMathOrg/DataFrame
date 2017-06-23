tests
testColumnFromTo

	| df expected |
	
	df := DataFrame columns: #(
		(0 0 0 0 1)
		(0 0 0 1 0)
		(0 0 1 0 0)
		(0 1 0 0 0)
		(1 0 0 0 0)).
		
	df columnNames: #(col1 col2 col3 col4 col5).
	df rowNames: #(row1 row2 row3 row4 row5).
		
	expected := DataFrame columns: #(
		(0 0 0 1 0)
		(0 0 1 0 0)
		(0 1 0 0 0)).
		
	expected columnNames: #(col2 col3 col4).
	expected rowNames: #(row1 row2 row3 row4 row5).
	
	self assert: (df columnsFrom: 2 to: 4) equals: expected.