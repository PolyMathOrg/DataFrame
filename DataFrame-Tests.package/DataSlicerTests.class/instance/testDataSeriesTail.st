tests
testDataSeriesTail

	| series slice |
	series := (10 to: 100 by: 10) asDataSeries.
	
	slice := series tail.

	self assert: (slice isKindOf: DataSeries).
	self assert: slice size equals: series defaultHeadTailSize.
	self assert: slice equals: { 6->60 . 7->70 . 8->80 . 9->90 . 10->100 } asDataSeries.