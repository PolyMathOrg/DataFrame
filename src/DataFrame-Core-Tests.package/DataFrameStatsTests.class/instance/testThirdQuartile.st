initialization
testThirdQuartile

	| expected actual |
	
	expected := { 6.4 . 3.3 . 5.1 . 1.8 . Float nan } asDataSeries.
	expected name: #thirdQuartile.
	expected keys: df columnNames.
	
	actual := df thirdQuartile.
	self assert: actual equals: expected.