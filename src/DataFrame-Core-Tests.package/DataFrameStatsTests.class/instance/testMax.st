initialization
testMax

	| expected actual |
	
	expected := { 7.9 . 4.4 . 6.9 . 2.5 . Float nan } asDataSeries.
	expected name: #max.
	expected keys: df columnNames.
	
	actual := df max.
	self assert: actual equals: expected.