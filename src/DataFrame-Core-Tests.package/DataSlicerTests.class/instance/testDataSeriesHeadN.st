tests
testDataSeriesHeadN

	| actual expected |
	
	expected := #(5.1 4.9 4.7) asDataSeries.
	expected name: series name.
	expected keys: (1 to: 3).
	
	actual := series head: 3.

	self assert: actual equals: expected.