printing
printOn: aStream

	super printOn: aStream.
	aStream cr.

	groups doWithIndex: [ :eachGroup :i |
		aStream
			nextPutAll: (groups keys at: i) asString;
			nextPutAll: ': '.
		eachGroup printOn: aStream.
		
		i = groups size
			ifFalse: [ aStream cr ] ]