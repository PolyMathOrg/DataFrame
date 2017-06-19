tests
testDataSeriesHeadN

	| series slice |
	series := (10 to: 100 by: 10) asDataSeries.
	
	slice := series head: 3.

	self assert: (slice isKindOf: DataSeries).
	self assert: slice equals: (10 to: 30 by: 10) asDataSeries.