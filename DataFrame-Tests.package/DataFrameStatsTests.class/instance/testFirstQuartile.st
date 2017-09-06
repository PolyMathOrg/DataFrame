initialization
testFirstQuartile

	| expected actual |
	
	expected := { 5.1 . 2.8 . 1.6 . 0.3 . Float nan } asDataSeries.
	expected name: #firstQuartile.
	expected keys: df columnNames.
	
	actual := df firstQuartile.
	self assert: actual equals: expected.