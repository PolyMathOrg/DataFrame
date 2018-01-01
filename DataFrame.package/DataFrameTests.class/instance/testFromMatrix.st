tests
testFromMatrix

	| matrix df expectedValues |
	
	matrix := Matrix
		rows: 3 columns: 3
		contents: #(
			'Robb Stark' 3 true
    		'Jon Snow' 4 false
      		'Eddard Stark' 1 true).
	
	df := DataFrame fromMatrix: matrix.
	
	self assert: df rowNames equals: #(1 2 3).
	self assert: df columnNames equals: #(1 2 3).
	
	"We know that it works, because we have tests for it in DataFrameInternalTests"
	expectedValues := DataFrameInternal fromMatrix: matrix.
	
	self assert: df contents equals: expectedValues.