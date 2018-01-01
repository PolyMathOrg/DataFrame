tests
testRemoveColumn

	| expected |
	
	expected := DataFrame fromRows: #(
		('Barcelona' true)
   		('Dubai' true)
   		('London' false)).
		
	expected rowNames: #(A B C).
	expected columnNames: #(City BeenThere).
		
	df removeColumn: #Population.
	
	self assert: df equals: expected.