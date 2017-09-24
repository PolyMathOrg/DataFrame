initialization
testOrderBy

	| expected |
	
	expected := DataFrame fromRows: #(
		('Lviv' 0.724 true)
		('Barcelona' 1.609 true)
   		('Dubai' 2.789 true)
		('London' 8.788 false)).
		
	expected columnNames: columnNames.
	expected rowNames: #(B A D C).
	
	df orderBy: #Population.
	
	self assert: df equals: expected.