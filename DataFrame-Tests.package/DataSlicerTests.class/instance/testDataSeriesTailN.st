tests
testDataSeriesTailN

	| actual expected |
	
	expected := #(6.5 6.2 5.9) asDataSeries.
	expected name: series name.
	expected keys:
		(series size - 3 + 1 to: series size).
	
	actual := series tail: 3.

	self assert: actual equals: expected.