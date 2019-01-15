initialization
testRemoveAt

	| expected |
	
	expected := DataSeriesInternal fromArray:
		#(10 30 40 50 60 70 80 90 100).
		
	series removeAt: 2.
		
	self assert: series equals: expected.