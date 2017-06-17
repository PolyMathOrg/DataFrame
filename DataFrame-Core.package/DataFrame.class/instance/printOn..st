printing
printOn: aStream

	( self size = 0 )
		ifTrue: [ super printOn: aStream. 
					aStream nextPutAll:' uninitialized'. ^ self ].
	self keysAndValuesDo: [ :key :value |
		key printOn: aStream.
		aStream tab.
		value asArray printOn: aStream.
		aStream cr ].