accessing
cellColumn: column row: rowNumber
	
	| columnNumber |
	
	column id = '#'
		ifTrue: [ ^ FTCellMorph new addMorph: rowNumber asMorph ].
		
	columnNumber := elements columnNames indexOf: column id.
	
	^ FTCellMorph new
		addMorph: (elements at: rowNumber at: columnNumber) asMorph.