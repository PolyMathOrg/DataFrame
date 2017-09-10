tests
testRemoveAtKey

	| expected |
	
	expected := #(10 20 40 50 60 70 80 90 100) asDataSeries.
	expected keys: ((1 to: 10) copyWithout: 3).
	expected name: series name.
	
	series removeAtKey: 3.
	
	self assert: series equals: expected.