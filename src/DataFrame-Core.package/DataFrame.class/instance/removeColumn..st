removing
removeColumn: columnName

	| index |
	index := self indexOfColumnNamed: columnName.
	self removeColumnAt: index.