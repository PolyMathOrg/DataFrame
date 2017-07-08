accessing
row: rowName

	| index |
	index := self rowNames indexOf: rowName.
	
	"If a row with that name does not exist"
	index = 0
		ifTrue: [ NotFoundError signal ].
		
	^ self rowAt: index