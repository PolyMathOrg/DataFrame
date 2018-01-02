tests
testRemoveColumnAt

	| expected |
	
	expected := DataFrameInternal fromRows: #(
		('Barcelona' true)
   		('Dubai' true)
   		('London' false)).
		
	df removeColumnAt: 2.
	
	self assert: df equals: expected.
	
