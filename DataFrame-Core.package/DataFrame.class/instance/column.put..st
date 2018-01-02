accessing
column: columnName put: anArray

	| index |
	index := self indexOfColumnNamed: columnName.
	^ self columnAt: index put: anArray.