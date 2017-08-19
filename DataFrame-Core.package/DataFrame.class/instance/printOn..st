printing
printOn: aStream

	DataPrettyPrinter new print: self on: aStream.

	"( self numberOfRows = 0 )
		ifTrue: [ super printOn: aStream. 
					aStream nextPutAll:' uninitialized'. ^ self ].
	
	aStream nextPutAll: '['.
	self columnNames
		do: [ :each | aStream nextPutAll: each asString ]
		separatedBy: [ aStream space ].
	aStream nextPutAll: ']'; cr.
				
	1 to: self numberOfRows - 1 do: [ :i  |
		(self rowNames at: i) printOn: aStream.
		aStream tab.
		
		1 to: self numberOfColumns - 1 do: [ :j |
			(self at: i at: j) printOn: aStream.
			aStream space ]."
		
		"Last one without a space"
		"(self at: i
			at: self numberOfColumns)
			printOn: aStream.
		
		aStream cr ]."
	
	"Last one without new line"
	"(self rowNames at: self numberOfRows) printOn: aStream.
	aStream tab.
		
	1 to: self numberOfColumns - 1 do: [ :j |
		(self at: self numberOfRows at: j) printOn: aStream.
		aStream space ]."
		
	"Last one without a space"
	"(self
		at: self numberOfRows
		at: self numberOfColumns)
		printOn: aStream.
		aStream space."