accessing
rowsAt: anArrayOfNumbers

	| df numberOfRows numberOfColumns |
	
	numberOfRows := anArrayOfNumbers size.
	numberOfColumns := self numberOfColumns.
	df := DataFrameInternal new: (numberOfRows @ numberOfColumns).
	
	anArrayOfNumbers doWithIndex: [ :i :k |
		1 to: numberOfColumns do: [ :j |
			df at: k at: j put: (self at: i at: j) ] ].
	
	^ df