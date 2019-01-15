converting
asArrayOfRows
	"Converts DataFrameInternal to the array of rows"

	^ (1 to: self numberOfRows) collect: [ :i |
		(1 to: self numberOfColumns) collect: [ :j |
			self at: i at: j ] ].