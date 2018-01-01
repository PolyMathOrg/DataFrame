tests
testAsStringTable

	| expected actual |
	
	expected := String new writeStream.
	expected
		nextPutAll: '   |  City       Population  BeenThere  '; cr;
		nextPutAll: '---+------------------------------------'; cr;
		nextPutAll: 'A  |  Barcelona       1.609       true  '; cr;
    	nextPutAll: 'B  |  Dubai           2.789       true  '; cr;
		nextPutAll: 'C  |  London          8.788      false  '; cr.
	
	expected := expected contents.
	actual := df asStringTable.
	
	self assert: actual equals: expected.