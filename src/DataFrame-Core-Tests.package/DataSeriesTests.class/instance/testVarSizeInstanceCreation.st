tests
testVarSizeInstanceCreation

	| aSeries |
	aSeries := DataSeries new: 10.
	self assert: aSeries size equals: 10.