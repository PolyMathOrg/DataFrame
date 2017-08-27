tests
testAddRow

	| expected |
	
	expected := DataFrameInternal fromRows: #(
		('Barcelona' 1.609 true)
   		('Dubai' 2.789 true)
   		('London' 8.788 false)
		('Lviv' 0.724 true)).
		
	df addRow: #('Lviv' 0.724 true).
	
	self assert: df equals: expected.
	
