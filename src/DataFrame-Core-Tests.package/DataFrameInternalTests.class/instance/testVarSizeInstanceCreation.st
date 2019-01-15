tests
testVarSizeInstanceCreation

	| dfActual |
	dfActual := DataFrameInternal new: 6@8.
	
	self assert: dfActual numberOfRows equals: 6.
	self assert: dfActual numberOfColumns equals: 8.