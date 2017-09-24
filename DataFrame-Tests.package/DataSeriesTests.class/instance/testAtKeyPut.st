tests
testAtKeyPut

	| expected |
	
	series atKey: #f put: -2.	
	expected := #(10 20 30 40 50 -2 70 80 90 100) asDataSeries.
	expected keys: keyArray.
	expected name: series name.
	
	self assert: series equals: expected.