tests
testTransposed

	| expected |
	
	expected := DataFrame fromRows: #(
		('Barcelona' 'Dubai' 'London')
		(1.609 2.789 8.788)
   		(true true false)).
		
	expected rowNames: df columnNames.
	expected columnNames: df rowNames.
	
	self assert: df transposed equals: expected.
	
