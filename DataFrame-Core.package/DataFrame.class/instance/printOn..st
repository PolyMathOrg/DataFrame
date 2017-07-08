printing
printOn: aStream

	( self size = 0 )
		ifTrue: [ super printOn: aStream. 
					aStream nextPutAll:' uninitialized'. ^ self ].
	
	aStream nextPutAll: '['.
	self columnNames
		do: [ :each | aStream nextPutAll: each ]
		separatedBy: [ aStream space ].
	aStream nextPutAll: ']'; cr.
				
	"self keysAndValuesDo: [ :key :value |
		key printOn: aStream.
		aStream tab.
		value asArray printOn: aStream.
		aStream cr ]."