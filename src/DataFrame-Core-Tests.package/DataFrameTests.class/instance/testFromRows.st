tests
testFromRows

	| rows df expectedValues |
	
	rows := #(
		('Robb Stark' 3 true)
    	('Jon Snow' 4 false)
      	('Eddard Stark' 1 true)).
	
	df := DataFrame fromRows: rows.
	
	self assert: df rowNames equals: #(1 2 3).
	self assert: df columnNames equals: #(1 2 3).
	
	"We know that it works, because we have tests for it in DataFrameInternalTests"
	expectedValues := DataFrameInternal fromRows: rows.
	
	self assert: df contents equals: expectedValues.