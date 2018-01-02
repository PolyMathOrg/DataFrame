tests
testAtKeyPutNewElement

	| expected |
	
	series atKey: #X put: -2.	
	expected := #(10 20 30 40 50 60 70 80 90 100 -2) asDataSeries.
	expected keys: (keyArray copyWith: #X).
	expected name: series name.
	
	self assert: series equals: expected.