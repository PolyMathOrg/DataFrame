tests
testAsStringTable

	| population expected actual |
	population := #(1.609 2.789 8.788) asDataSeries.
	population keys: #(Barcelona Dubai London).
	population name: #Population.
	
	expected := String new writeStream.
	expected
		nextPutAll: '           |  Population  '; cr;
		nextPutAll: '-----------+--------------'; cr;
		nextPutAll: 'Barcelona  |       1.609  '; cr;
    	nextPutAll: '    Dubai  |       2.789  '; cr;
		nextPutAll: '   London  |       8.788  '; cr.
	
	expected := expected contents.
	actual := population asStringTable.
	
	self assert: actual equals: expected.