private
indexOfColumnNamed: columnName

	| index |
	index := self columnNames indexOf: columnName.
	
	"If a column with that name does not exist"
	index = 0
		ifTrue: [ NotFoundError signal:
			('Column ', columnName, ' was not found') ].
		
	^ index