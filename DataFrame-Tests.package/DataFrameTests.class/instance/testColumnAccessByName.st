tests
testColumnAccessByName

	| df expectedColumn |
	
	df := DataFrame rows: #((1 2)(3 4)).
	df columnNames: #(a b).
	
	expectedColumn := #(1 3) asDataSeries.
	expectedColumn name: 'a'.
		
	self assert: (df isKindOf: DataFrame).
	self assert: (df column: 'a') equals: expectedColumn.