tests
testAddAtKey

	| expected |
	
	series add: -2 atKey: #X.	
	expected := #(10 20 30 40 50 60 70 80 90 100 -2) asDataSeries.
	expected keys: ((1 to: 10) copyWith: #X).
	expected name: series name.
	
	self assert: series equals: expected.