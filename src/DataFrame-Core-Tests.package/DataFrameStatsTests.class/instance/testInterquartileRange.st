initialization
testInterquartileRange

	| expected actual |
	
	expected := { 1.3 . 0.5 . 3.5 . 1.5 . Float nan } asDataSeries.
	expected name: #interquartileRange.
	expected keys: df columnNames.
	
	actual := df interquartileRange.
	self assert: actual closeTo: expected.