initialization
testRange

	| expected actual |
	
	expected := { 3.6 . 2.4 . 5.9 . 2.4 . Float nan } asDataSeries.
	expected name: #range.
	expected keys: df columnNames.
	
	actual := df range.
	self assert: actual closeTo: expected.