tests
testAddRow

	| expected |
	
	expected := DataFrame fromRows: #(
		('Barcelona' 1.609 true)
   		('Dubai' 2.789 true)
   		('London' 8.788 false)
		('Lviv' 0.724 true)).
		
	expected rowNames: #(A B C D).
	expected columnNames: #(City Population SomeBool).
		
	df addRow: #('Lviv' 0.724 true) named: #D.
	
	self assert: df equals: expected.