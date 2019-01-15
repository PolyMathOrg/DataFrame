initialization
testMin

	| expected actual |
	
	expected := { 4.3 . 2 . 1 . 0.1 . Float nan } asDataSeries.
	expected name: #min.
	expected keys: df columnNames.
	
	actual := df min.
	self assert: actual equals: expected.