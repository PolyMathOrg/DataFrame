initialization
testAtPut

	| expected |
	
	series at: 6 put: -2.	
	expected := DataSeriesInternal fromArray:
		#(10 20 30 40 50 -2 70 80 90 100).
	
	self assert: series equals: expected.