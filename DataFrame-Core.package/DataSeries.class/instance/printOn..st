printing
printOn: aStream

	self name isNil
		ifTrue: [ aStream nextPutAll: '(unnamed)' ]
		ifFalse: [ aStream nextPutAll: '[', self name asString, ']' ].
		
	aStream cr.
	
	self keysAndValuesDo: [ :key :value |
		aStream nextPutAll: key asString.
		aStream tab.
		aStream nextPutAll: value asString.
		aStream cr ].