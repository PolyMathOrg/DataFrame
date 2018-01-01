accessing
row: rowName

	| index |
	index := self indexOfRowNamed: rowName.
	^ self rowAt: index