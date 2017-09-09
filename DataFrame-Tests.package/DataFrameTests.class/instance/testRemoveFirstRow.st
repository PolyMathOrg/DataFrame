tests
testRemoveFirstRow

	| expected |
	
	expected := DataFrame fromRows: #(
   		('Dubai' 2.789 true)
   		('London' 8.788 false)).
		
	expected rowNames: #(B C).
	expected columnNames: #(City Population BeenThere).
		
	df removeFirstRow.
	
	self assert: df equals: expected.