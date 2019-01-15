accessing
row: rowName put: anArray

	| index |
	index := self indexOfRowNamed: rowName.
	^ self rowAt: index put: anArray.