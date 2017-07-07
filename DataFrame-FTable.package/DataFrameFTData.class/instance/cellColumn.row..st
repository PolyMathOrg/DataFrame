accessing
cellColumn: column row: rowIndex
	
	column id = '#'
		ifTrue: [ ^ FTCellMorph new addMorph: rowIndex asMorph ].
	
	^ FTCellMorph new
		addMorph: ((self elementAt: rowIndex) at: column id) asMorph.