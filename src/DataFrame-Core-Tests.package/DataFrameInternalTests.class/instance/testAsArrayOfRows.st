tests
testAsArrayOfRows

	| expected |
	
	expected := #(
		('Barcelona' 1.609 true)
   		('Dubai' 2.789 true)
   		('London' 8.788 false)).
	
	self assert: df asArrayOfRows equals: expected.
	
