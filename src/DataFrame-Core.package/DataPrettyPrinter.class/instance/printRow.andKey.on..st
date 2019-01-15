printing
printRow: aRow andKey: aKey on: aStream

	| cellStr offset |
	
	cellStr := aKey asString.
	
	offset := self offsetWithSpaces:
			((columnLengths at: 1) - cellStr size).
			
	(columnAligns at: 1) = #RIGHT
			ifTrue: [ cellStr := offset, cellStr ].
		(columnAligns at: 1) = #LEFT
			ifTrue: [ cellStr := cellStr, offset ].
			
	aStream
			nextPutAll: cellStr;
			nextPutAll: separator;
			nextPutAll: '|';
			nextPutAll: separator.

	1 to: aRow size do: [ :i |
		cellStr := (aRow at: i) asString.
		offset := self offsetWithSpaces:
			((columnLengths at: i + 1) - cellStr size).
			
		(columnAligns at: i) = #RIGHT
			ifTrue: [ cellStr := offset, cellStr ].
		(columnAligns at: i) = #LEFT
			ifTrue: [ cellStr := cellStr, offset ].
				
		aStream
			nextPutAll: cellStr;
			nextPutAll: separator. ].