tests
testAtPut

	| expected |
	
	series at: 6 put: -2.	
	expected := #(10 20 30 40 50 -2 70 80 90 100) asDataSeries.
	
	self assert: series equals: expected.