initialization
testDataFrameGroupedPrintOn

	| expected actual |
	
	expected := String new writeStream.
	expected
		nextPutAll: 'a DataFrameGrouped'; cr;
		nextPutAll: '''Female'''; cr;
		nextPutAll: '   |  total_bill   tip  smoker  day  time    size  '; cr;
		nextPutAll: '---+-----------------------------------------------'; cr;
		nextPutAll: '1  |       16.99  1.01  No      Sun  Dinner     2  '; cr;
		nextPutAll: '2  |       24.59  3.61  No      Sun  Dinner     4  '; cr; cr; cr;
		nextPutAll: '''Male'''; cr;
		nextPutAll: '   |  total_bill   tip  smoker  day  time    size  '; cr;
		nextPutAll: '---+-----------------------------------------------'; cr;
		nextPutAll: '1  |       10.34  1.66  No      Sun  Dinner     3  '; cr;
		nextPutAll: '2  |       21.01   3.5  No      Sun  Dinner     3  '; cr;
		nextPutAll: '3  |       23.68  3.31  No      Sun  Dinner     2  '; cr.
	expected := expected contents.
	
	actual := String new writeStream.
	(df groupBy: #sex) printOn: actual.
	actual := actual contents.
	
	self assert: actual equals: expected.