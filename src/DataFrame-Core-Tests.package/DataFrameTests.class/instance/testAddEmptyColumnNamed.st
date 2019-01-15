tests
testAddEmptyColumnNamed

	| expected |
	
	expected := DataFrame fromRows: #(
		('Barcelona' 1.609 true nil)
   		('Dubai' 2.789 true nil)
   		('London' 8.788 false nil)).
		
	expected rowNames: #(A B C).
	expected columnNames: #(City Population BeenThere EmptyColumn).
		
	df addEmptyColumnNamed: #EmptyColumn.
	
	self assert: df equals: expected.