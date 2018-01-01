tests
testAtAtPut

	| matrix dfActual |
	
	matrix := Matrix rows: 3 columns: 2
		contents: #(1 2 3 4 5 6).
		
	dfActual := DataFrameInternal fromMatrix: matrix.
	
	matrix at: 2 at: 2 put: 10.
	dfActual at: 2 at: 2 put: 10.
	
	self assert: matrix equals: dfActual.