tests
testStd

	| a | 
	a := #(-1 2 1 4 3 0 1 2) asDataSeries.
	self assert: a stdev closeTo: 1.60356.