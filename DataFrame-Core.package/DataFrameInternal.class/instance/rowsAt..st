accessing
rowsAt: anArrayOfNumbers

	| dfInternal numberOfRows numberOfColumns |
	
	numberOfRows := anArrayOfNumbers size.
	numberOfColumns := self numberOfColumns.
	dfInternal := DataFrameInternal new: (numberOfRows @ numberOfColumns).
	
	anArrayOfNumbers doWithIndex: [ :i :k |
		1 to: numberOfColumns do: [ :j |
			dfInternal at: k at: j put: (self at: i at: j) ] ].
	
	^ dfInternal.