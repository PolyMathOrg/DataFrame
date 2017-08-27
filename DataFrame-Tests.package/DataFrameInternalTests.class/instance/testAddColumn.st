tests
testAddColumn

	| expected |
	
	expected := DataFrameInternal fromRows: #(
		('Barcelona' 1.609 true 9)
   		('Dubai' 2.789 true 8)
   		('London' 8.788 false 7)).
		
	df addColumn: #(9 8 7).
	
	self assert: df equals: expected.
	
