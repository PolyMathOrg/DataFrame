printing
printOn: aStream

	( self size = 0 )
		ifTrue: [ super printOn: aStream. 
					aStream nextPutAll:' uninitialized'. ^ self ].
	self 
		do: [ :each |
			each name printOn: aStream.
			aStream tab.
			each printOn: aStream]
		separatedBy: [ aStream cr].