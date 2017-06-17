printing
printOn: aStream

	self name printOn: aStream.
	aStream cr.
	
	self keysAndValuesDo: [ :key :value |
		aStream nextPutAll: key asString.
		aStream tab.
		aStream nextPutAll: value asString.
		aStream cr ].