tests
testPrintOn

	| expected actual |
	
	expected := String new writeStream.
	expected
		nextPutAll: '(''Barcelona'' 1.609 true'; cr;
		nextPutAll: '''Dubai'' 2.789 true'; cr;
		nextPutAll: '''London'' 8.788 false )'.
	expected := expected contents.
	
	actual := String new writeStream.
	df printOn: actual.
	actual := actual contents.
	
	self assert: actual equals: expected.