initialization
testAverage

	| expected actual |
	
	expected := { 5.8433 . 3.054 . 3.7586 . 1.1986 . Float nan } asDataSeries.
	expected name: #average.
	expected keys: df columnNames.
	
	actual := df average.
	self assert: actual closeTo: expected.