initialization
testDataSeriesGroupedPrintOn

	| expected actual |
	
	expected := String new writeStream.
	expected
		nextPutAll: 'a DataSeriesGrouped'; cr;
		nextPutAll: 'Female	(16.99 24.59)'; cr;
		nextPutAll: 'Male	(10.34 21.01 23.68)'.
	expected := expected contents.
	
	actual := String new writeStream.
	(df group: #total_bill by: #sex) printOn: actual.
	actual := actual contents.
	
	self assert: actual equals: expected.