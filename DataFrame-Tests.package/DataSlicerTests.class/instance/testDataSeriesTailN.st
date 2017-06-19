tests
testDataSeriesTailN

	| series slice |
	series := (10 to: 100 by: 10) asDataSeries.
	
	slice := series tail: 3.

	self assert: (slice isKindOf: DataSeries).
	self assert: slice equals: { 8->80 . 9->90 . 10->100 } asDataSeries.