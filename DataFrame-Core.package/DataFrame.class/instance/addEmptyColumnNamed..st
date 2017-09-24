adding
addEmptyColumnNamed: columnName

	self
		addColumn: (Array new: self numberOfRows)
		named: columnName.