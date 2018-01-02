sorting
orderBy: columnName

	self orderBy: columnName using: [ :a :b | a <= b ].