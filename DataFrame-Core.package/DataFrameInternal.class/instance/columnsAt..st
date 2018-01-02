accessing
columnsAt: anArrayOfNumbers

	| dfInternal numberOfRows numberOfColumns |
	
	numberOfRows := self numberOfRows.
	numberOfColumns := anArrayOfNumbers size.
	dfInternal := DataFrameInternal new: (numberOfRows @ numberOfColumns).
	
	1 to: numberOfRows do: [ :i |
		anArrayOfNumbers doWithIndex: [ :j :k |
			dfInternal at: i at: k put: (self at: i at: j) ] ].
	
	^ dfInternal.