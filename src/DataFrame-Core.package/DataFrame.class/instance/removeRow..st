removing
removeRow: rowName

	| index |
	index := self indexOfRowNamed: rowName.
	self removeRowAt: index.