printing
printOn: aStream

	super printOn: aStream.
	aStream cr.
	
	groups doWithIndex: [ :eachDataFrame :i |
		aStream
			nextPutAll: (groups keys at: i) asString;
			nextPutAll: ': '.
		eachDataFrame printOn: aStream.
		
		i = groups size
			ifFalse: [ aStream cr ] ] 