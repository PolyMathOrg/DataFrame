initialization
testDataFrameGroupedPrintOn

	| expected actual |
	
	expected := String new writeStream.
	expected
		nextPutAll: 'a DataFrameGrouped'; cr;
		nextPutAll: 'Female: a DataFrame (2@6)'; cr;
		nextPutAll: 'Male: a DataFrame (3@6)'.
	expected := expected contents.
	
	actual := String new writeStream.
	(df groupBy: #sex) printOn: actual.
	actual := actual contents.
	
	self assert: actual equals: expected.