tests
testFromColumns

	| columns df expectedValues |
	
	columns := #(
		('Robb Stark' 'Jon Snow' 'Eddard Stark')
    	(3 4 1)
      	(true false true)).
	
	df := DataFrame fromColumns: columns.
	
	self assert: df rowNames equals: #(1 2 3).
	self assert: df columnNames equals: #(1 2 3).
	
	"We know that it works, because we have tests for it in DataFrameInternalTests"
	expectedValues := DataFrameInternal fromColumns: columns.
	
	self assert: df contents equals: expectedValues.