tests
testDataSeriesHead

	| series slice |
	series := (10 to: 100 by: 10) asDataSeries.
	
	slice := series head.

	self assert: (slice isKindOf: DataSeries).
	self assert: slice size equals: series defaultHeadTailSize.
	self assert: slice equals: (10 to: 50 by: 10) asDataSeries.