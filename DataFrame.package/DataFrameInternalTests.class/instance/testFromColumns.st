tests
testFromColumns

	| dfActual dfExpected |
	
	dfExpected := DataFrameInternal fromMatrix: 		(Matrix rows: 3 columns: 2 contents: #(1 2 3 4 5 6)).
		
	dfActual := DataFrameInternal fromColumns: #((1 3 5)(2 4 6)).
	
	self assert: dfActual equals: dfExpected.