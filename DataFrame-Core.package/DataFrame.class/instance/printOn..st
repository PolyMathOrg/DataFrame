printing
printOn: aStream

	( self numberOfRows = 0 )
		ifTrue: [ super printOn: aStream. 
					aStream nextPutAll:' uninitialized'. ^ self ].
	
	aStream nextPutAll: '['.
	self columnNames
		do: [ :each | aStream nextPutAll: each asString ]
		separatedBy: [ aStream space ].
	aStream nextPutAll: ']'; cr.
				
	1 to: self numberOfRows do: [ :i  |
		(self rowNames at: i) printOn: aStream.
		aStream tab.
		'(' printOn: aStream.
		
		1 to: self numberOfColumns - 1 do: [ :j |
			(self at: i at: j) printOn: aStream.
			aStream space ].
		
		"Last one without a space"
		(self at: i at: (self numberOfColumns)) printOn: aStream.
		')' printOn: aStream.
		aStream cr ].