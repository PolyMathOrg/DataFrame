tests
testLoadHousing
	
	| df expectedSeries |
	df := DataFrame loadHousing.
	
	"First we check if the dimensions are equal to what we expected"
	self assert: df numberOfRows equals: 489.
	self assert: df numberOfColumns equals: 4.
	
	"Then we check the row and column names"
	self assert: df columnNames equals: #(RM LSTAT PTRATIO MDEV).
	self assert: df rowNames equals: (1 to: df numberOfRows).
	
	"First row (any row) should be a data series with name corresponding to the row name and keys equal to column names"
	expectedSeries := #(6.575 4.98 15.3 504000.0) asDataSeries.
	expectedSeries name: 1.
	expectedSeries keys: df columnNames.
	
	self assert: (df row: 1) equals: expectedSeries.
	
	"First column (any column) should be a data series with name corresponding to the column name and keys equal to row names. We don't want to check all the values manually, so we just look at the mean"
	self assert: (df column: #RM) average closeTo: 6.24.
	self assert: (df column: #RM) name equals: #RM.
	self assert: (df column: #RM) keys equals: df rowNames.