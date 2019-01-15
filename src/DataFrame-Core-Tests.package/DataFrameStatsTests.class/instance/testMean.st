initialization
testMean

	| expected actual |
	
	expected := { 5.84 . 3.05 . 3.76 . 1.2 . Float nan } asDataSeries.
	expected name: #mean.
	expected keys: df columnNames.
	
	actual := df mean.
	self assert: actual equals: expected.