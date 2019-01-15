initialization
testVariance

	| expected actual |
	
	expected := { 0.68569 . 0.188 . 3.11317 . 0.58241 . Float nan } asDataSeries.
	expected name: #variance.
	expected keys: df columnNames.
	
	actual := df variance.
	self assert: actual closeTo: expected.