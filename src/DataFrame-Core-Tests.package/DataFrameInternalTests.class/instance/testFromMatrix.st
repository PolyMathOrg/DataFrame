tests
testFromMatrix

	| matrix dfActual |
	
	matrix := Matrix rows: 3 columns: 2
		contents: #(1 2 3 4 5 6).
		
	dfActual := DataFrameInternal fromMatrix: matrix.
	
	self assert: matrix equals: dfActual.