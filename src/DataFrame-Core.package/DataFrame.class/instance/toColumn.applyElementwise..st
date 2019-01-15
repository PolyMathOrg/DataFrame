applying
toColumn: columnName applyElementwise: aBlock
		
	| index |
	index := self columnNames indexOf: columnName.
	
	"If a column with that name does not exist"
	index = 0
		ifTrue: [ NotFoundError signal ].
		
	self toColumnAt: index applyElementwise: aBlock.