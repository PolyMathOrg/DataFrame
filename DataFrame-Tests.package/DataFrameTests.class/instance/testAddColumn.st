tests
testAddColumn

	| expected |
	
	expected := DataFrame fromRows: #(
		('Barcelona' 1.609 true 9)
   		('Dubai' 2.789 true 8)
   		('London' 8.788 false 7)).
		
	expected rowNames: #(A B C).
	expected columnNames: #(City Population SomeBool SomeInt).
		
	df addColumn: #(9 8 7) named: #SomeInt.
	
	self assert: df equals: expected.