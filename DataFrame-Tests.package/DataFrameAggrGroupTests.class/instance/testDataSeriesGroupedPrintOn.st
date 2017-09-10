initialization
testDataSeriesGroupedPrintOn

	| expected actual |
	
	expected := String new writeStream.
	expected
		nextPutAll: 'a DataSeriesGrouped'; cr;
		nextPutAll: ('Female: a DataSeries [2 items]: ', 21.01 class name); cr;
		nextPutAll: ('Male: a DataSeries [3 items]: ', 21.01 class name).
	expected := expected contents.
	
	actual := String new writeStream.
	(df group: #total_bill by: #sex) printOn: actual.
	actual := actual contents.
	
	self assert: actual equals: expected.