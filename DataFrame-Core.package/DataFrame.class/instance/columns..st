accessing
columns: anArrayOfNames
	
	| anArrayOfNumbers |
	
	anArrayOfNumbers := anArrayOfNames
		collect: [ :name |
			self indexOfColumnNamed: name ].
			
	^ self columnsAt: anArrayOfNumbers.