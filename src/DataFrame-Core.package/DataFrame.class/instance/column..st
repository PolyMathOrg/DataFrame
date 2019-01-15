accessing
column: columnName

	| index |
	index := self indexOfColumnNamed: columnName.
	^ self columnAt: index