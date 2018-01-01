tests
testToColumnApplyElementwise

	| expected |
	
	expected := DataFrame fromRows: #(
		('Barcelona' '1.609' true)
   		('Dubai' '2.789' true)
   		('London' '8.788' false)).
		
	expected rowNames: #(A B C).
	expected columnNames: #(City Population BeenThere).
		
	df toColumn: #Population
		applyElementwise: [ :each | each asString ].
	
	self assert: df equals: expected.