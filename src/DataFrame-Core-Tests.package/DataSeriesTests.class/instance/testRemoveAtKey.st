tests
testRemoveAtKey

	| expected |
	
	expected := #(10 20 40 50 60 70 80 90 100) asDataSeries.
	expected keys: (keyArray copyWithout: #c).
	expected name: series name.
	
	series removeAtKey: #c.
	
	self assert: series equals: expected.