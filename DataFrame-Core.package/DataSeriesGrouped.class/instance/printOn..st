printing
printOn: aStream

	super printOn: aStream.
	aStream cr.

	groups doWithIndex: [ :eachGroup :i |
		aStream nextPutAll: (groups keys at: i) asString.
		aStream tab.
		aStream nextPutAll: '('.
		
		eachGroup doWithIndex: [ :each :j |
			each printOn: aStream.
			
			j = eachGroup size
				ifFalse: [ aStream space ] ].
		
		aStream nextPutAll: ')'.
		
		i = groups size
			ifFalse: [ aStream cr ] ]