geometry
transposed
	"Returs a transposed DataFrame. Columns become rows and rows become columns."

	| transposedDf |
	transposedDf := DataFrame fromRows: (self asArrayOfColumns).
	transposedDf rowNames: self columnNames.
	transposedDf columnNames: self rowNames.
	^ transposedDf