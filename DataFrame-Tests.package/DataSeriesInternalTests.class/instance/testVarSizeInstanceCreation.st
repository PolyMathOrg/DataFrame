initialization
testVarSizeInstanceCreation

	| seriesInternal |
	
	seriesInternal := DataSeriesInternal new: 10.
	self assert: seriesInternal size equals: 10.