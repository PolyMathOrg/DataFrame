Class {
	#name : #DataSetsTests,
	#superclass : #TestCase,
	#category : 'DataFrame-Tools-Tests'
}

{ #category : #tests }
DataSetsTests >> testLoadHousing [
	
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
]

{ #category : #tests }
DataSetsTests >> testLoadIris [
	
	| df expectedSeries |
	df := DataFrame loadIris.
	
	"First we check if the dimensions are equal to what we expected"
	self assert: df numberOfRows equals: 150.
	self assert: df numberOfColumns equals: 5.
	
	"Then we check the row and column names"
	self assert: df columnNames equals: #(sepal_length sepal_width petal_length petal_width species).
	self assert: df rowNames equals: (1 to: df numberOfRows).
	
	"First row (any row) should be a data series with name corresponding to the row name and keys equal to column names"
	expectedSeries := #(5.1 3.5 1.4 0.2 setosa) asDataSeries.
	expectedSeries name: 1.
	expectedSeries keys: df columnNames.
	
	self assert: (df row: 1) equals: expectedSeries.
	
	"First column (any column) should be a data series with name corresponding to the column name and keys equal to row names. We don't want to check all the values manually, so we just look at the mean"
	self assert: (df column: #sepal_length) average closeTo: 5.843.
	self assert: (df column: #sepal_length) name equals: #sepal_length.
	self assert: (df column: #sepal_length) keys equals: df rowNames.
]
