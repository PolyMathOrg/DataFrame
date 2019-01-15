tests
testRemoveLastRow

	| expected |
	
	expected := DataFrame fromRows: #(
		('Barcelona' 1.609 true)
   		('Dubai' 2.789 true)).
		
	expected rowNames: #(A B).
	expected columnNames: #(City Population BeenThere).
		
	df removeLastRow.
	
	self assert: df equals: expected.