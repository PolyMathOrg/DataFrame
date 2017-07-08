accessing
column: colName

	| index |
	index := self columnNames indexOf: colName.
	
	"If a column with that name does not exist"
	index = 0
		ifTrue: [ NotFoundError signal ].
		
	^ self columnAt: index