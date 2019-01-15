tests
testPrintOn

	| population expected actual |
	population := #(1.609 2.789 8.788) asDataSeries.
	population keys: #(Barcelona Dubai London).
	population name: #Population.
	
	expected := 'a DataSeries [3 items]: ', 1.609 class name.
	
	actual := String new writeStream.
	population printOn: actual.
	actual := actual contents.
	
	self assert: actual equals: expected.