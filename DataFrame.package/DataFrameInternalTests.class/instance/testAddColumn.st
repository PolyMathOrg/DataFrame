tests
testAddColumn

	| expected |
	
	expected := DataFrameInternal fromRows: #(
		('Barcelona' 1.609 true 4)
   		('Dubai' 2.789 true 3)
   		('London' 8.788 false 4)).
		
	df addColumn: #(4 3 4).
	
	self assert: df equals: expected.
	
