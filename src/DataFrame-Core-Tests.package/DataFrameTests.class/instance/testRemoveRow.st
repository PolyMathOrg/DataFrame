tests
testRemoveRow

	| expected |
	
	expected := DataFrame fromRows: #(
		('Barcelona' 1.609 true)
   		('London' 8.788 false)).
		
	expected rowNames: #(A C).
	expected columnNames: #(City Population BeenThere).
		
	df removeRow: #B.
	
	self assert: df equals: expected.