accessing
columns: anArrayOfNames
	
	| anArrayOfNumbers |
	
	anArrayOfNumbers := anArrayOfNames
		collect: [ :name |
			| index |
			index := self columnNames indexOf: name.
			
			"If one of them was not found - throw an exception"
			index = 0
				ifTrue: [ Error signal:
					('Column ', name, ' was not found') ].
			
			"We are collecting these indices"
			index ].
			
	^ self columnsAt: anArrayOfNumbers.