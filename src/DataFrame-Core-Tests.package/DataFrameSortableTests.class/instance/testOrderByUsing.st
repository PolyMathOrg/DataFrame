initialization
testOrderByUsing

	| expected |
	
	expected := DataFrame fromRows: #(
		('London' 8.788 false)
		('Dubai' 2.789 true)
		('Barcelona' 1.609 true)
		('Lviv' 0.724 true)).
		
	expected columnNames: columnNames.
	expected rowNames: #(C D A B).
	
	df orderBy: #Population using: [ :a :b | a >= b ].
	
	self assert: df equals: expected.