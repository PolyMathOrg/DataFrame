initialization
testMode

	| expected actual |
	
	expected := { 5 . 3 . 1.5 . 0.2 . Float nan } asDataSeries.
	expected name: #mode.
	expected keys: df columnNames.
	
	actual := df mode.
	self assert: actual equals: expected.