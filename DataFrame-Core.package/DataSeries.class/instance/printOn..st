printing
printOn: aStream

	aStream nextPutAll: '(' asString.
	
	self do: [ :v |
		aStream nextPutAll: v asString, ' ' ].
	
	aStream nextPutAll: ')' asString.