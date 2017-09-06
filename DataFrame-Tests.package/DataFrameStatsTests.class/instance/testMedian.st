initialization
testMedian

	| expected actual |
	
	expected := { 5.8 . 3 . 4.3 . 1.3 . Float nan } asDataSeries.
	expected name: #median.
	expected keys: df columnNames.
	
	actual := df median.
	self assert: actual equals: expected.