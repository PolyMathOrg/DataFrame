accessing
columnsAt: anArrayOfNumbers

	| df numberOfRows numberOfColumns |
	
	numberOfRows := self numberOfRows.
	numberOfColumns := anArrayOfNumbers size.
	df := DataFrameInternal new: (numberOfRows @ numberOfColumns).
	
	1 to: numberOfRows do: [ :i |
		anArrayOfNumbers doWithIndex: [ :j :k |
			df at: i at: k put: (self at: i at: j) ] ].
	
	^ df