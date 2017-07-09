tests
testDataSeriesTail

	| actual expected |
	
	expected := #(6.7 6.3 6.5 6.2 5.9) asDataSeries.
	expected name: series name.
	expected keys:
		(series size - series defaultHeadTailSize + 1 to: series size).
	
	actual := series tail.

	self assert: actual equals: expected.