tests
testAddColumn

	| expected |
	
	expected := DataFrame fromRows: #(
		('Barcelona' 1.609 true 4)
   		('Dubai' 2.789 true 3)
   		('London' 8.788 false 4)).
		
	expected rowNames: #(A B C).
	expected columnNames: #(City Population BeenThere Rating).
		
	df addColumn: #(4 3 4) named: #Rating.
	
	self assert: df equals: expected.