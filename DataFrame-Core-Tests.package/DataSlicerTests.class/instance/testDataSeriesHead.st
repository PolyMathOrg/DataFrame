tests
testDataSeriesHead

	| actual expected |
	
	expected := #(5.1 4.9 4.7 4.6 5) asDataSeries.
	expected name: series name.
	expected keys: (1 to: series defaultHeadTailSize).
	
	actual := series head.

	self assert: actual equals: expected.