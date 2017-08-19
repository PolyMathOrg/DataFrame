printing
printLineOn: aStream

	| numberOfColumns sumColLen sumOffset keySideLen valSideLen |
	
	numberOfColumns := columnLengths size.
	sumColLen := columnLengths sum - (columnLengths at: 1).
	sumOffset := (separator size) * numberOfColumns.
	
	keySideLen := (columnLengths at: 1) + (separator size).
	valSideLen := sumColLen + sumOffset.
	
	1 to: keySideLen do: [ :i |
		aStream nextPutAll: '-' ].
	
	aStream nextPutAll: '+'.
	
	1 to: valSideLen do: [ :i |
		aStream nextPutAll: '-' ].