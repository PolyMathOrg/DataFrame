adding
addEmptyColumnNamed: columnName
"Create an empty column with a given name at the end of DataFrame. The values of a new column will be set equal to nil"

	self
		addColumn: (Array new: self numberOfRows)
		named: columnName.