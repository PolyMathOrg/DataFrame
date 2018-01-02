initialization
testStdev

	| expected actual |
	
	expected := { 0.82806 . 0.43359 . 1.76442 . 0.76316 . Float nan } asDataSeries.
	expected name: #stdev.
	expected keys: df columnNames.
	
	actual := df stdev.
	self assert: actual closeTo: expected.