*DataFrame-Tools-Tabular
fromXLSXworksheet: sheet
	
	| matrix df |
	
	matrix := sheet cellValuesAsMatrix.
	df := self new initializeMatrix: matrix.
	^ df