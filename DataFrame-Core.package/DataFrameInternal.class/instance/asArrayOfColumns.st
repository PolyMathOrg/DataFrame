converting
asArrayOfColumns
	"Converts DataFrameInternal to the array of columns"

	^ (1 to: self numberOfColumns) collect: [ :j |
		(1 to: self numberOfRows) collect: [ :i |
			self at: i at: j ] ].