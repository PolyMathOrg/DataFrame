adding
addColumn: anArray named: columnName

	contents addColumn: anArray.
	columnNames := columnNames copyWith: columnName.
	
	columnTypes := columnTypes copyWith: nil. "Extend an array"
	self induceColumnTypeAt: (self numberOfColumns).