tests
testRemoveColumnAt

	| expected |
	
	expected := DataFrame fromRows: #(
		('Barcelona' true)
   		('Dubai' true)
   		('London' false)).
		
	expected rowNames: #(A B C).
	expected columnNames: #(City BeenThere).
		
	df removeColumnAt: 2.
	
	self assert: df equals: expected.