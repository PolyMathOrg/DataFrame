tests
testRemoveRowAt

	| expected |
	
	expected := DataFrameInternal fromRows: #(
		('Barcelona' 1.609 true)
   		('London' 8.788 false)).
		
	df removeRowAt: 2.
	
	self assert: df equals: expected.
	
