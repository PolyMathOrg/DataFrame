accessing
rows: anArrayOfNames
	
	| anArrayOfNumbers |
	
	anArrayOfNumbers := anArrayOfNames
		collect: [ :name |
			self indexOfRowNamed: name ].
			
	^ self rowsAt: anArrayOfNumbers.