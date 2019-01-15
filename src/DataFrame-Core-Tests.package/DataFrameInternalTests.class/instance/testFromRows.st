tests
testFromRows
	
	| dfActual dfExpected |
	
	dfExpected := DataFrameInternal fromMatrix: 		(Matrix rows: 3 columns: 2 contents: #(1 2 3 4 5 6)).
		
	dfActual := DataFrameInternal fromRows: #((1 2)(3 4)(5 6)).
	
	self assert: dfActual equals: dfExpected.
	
	