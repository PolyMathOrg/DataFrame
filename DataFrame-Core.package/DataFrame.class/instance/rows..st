not implemented
rows: anArrayOfNames
	
	| anArrayOfNumbers |
	
	anArrayOfNumbers := anArrayOfNames
		collect: [ :name |
			| index |
			index := self rowNames indexOf: name.
			
			"If one of them was not found - throw an exception"
			index = 0
				ifTrue: [ Error signal:
					('Row ', name, ' was not found') ].
			
			"We are collecting these indices"
			index ].
			
	^ self rowsAt: anArrayOfNumbers.