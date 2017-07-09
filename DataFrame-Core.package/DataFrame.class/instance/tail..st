accessing
tail: aNumber

	| n rows |
	
	rows := self numberOfRows.
	
	rows > aNumber
		ifTrue: [ n := aNumber ]
		ifFalse: [ n := rows ].
			
	^ self rowsAt: ((rows - n + 1) to: rows).