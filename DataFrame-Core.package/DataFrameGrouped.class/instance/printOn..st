printing
printOn: aStream

	super printOn: aStream.
	aStream cr.
	
	groups doWithIndex: [ :eachDataFrame :i |
		(groups keys at: i) printOn: aStream.
		aStream cr.
		eachDataFrame printOn: aStream.
		
		i = groups size
			ifFalse: [ aStream cr; cr ] ] 