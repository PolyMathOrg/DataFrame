initialization
testPrintOn

	| population expected actual |
	population := DataSeriesInternal fromArray: #(1.609 2.789 8.788).
	
	expected := '#(1.609 2.789 8.788)'.
	
	actual := String new writeStream.
	population printOn: actual.
	actual := actual contents.
	
	self assert: actual equals: expected.