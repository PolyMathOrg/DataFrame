printing
printOn: aStream
	
	self keysAndValuesDo: [ :key :value |
		aStream nextPutAll: key asString.
		aStream tab.
		aStream nextPutAll: value asString.
		aStream cr ].