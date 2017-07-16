printing
printOn: aStream

	aStream nextPutAll: 'a '.
	self class printOn: aStream.
	aStream cr.

	self name isNil
		ifFalse: [
			aStream nextPutAll: '''', self name asString, ''''.
			aStream cr ].
	
	self withIndexDo: [ :each :i |
		aStream nextPutAll: (self keys at: i) asString.
		aStream tab.
		each printOn: aStream.
		
		i = self size 
			ifFalse: [ aStream cr ] ].