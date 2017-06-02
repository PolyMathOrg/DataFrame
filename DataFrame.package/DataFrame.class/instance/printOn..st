printing
printOn: aStream

	(rows isNil or: [rows size = 0])
		ifTrue: [ super printOn: aStream. 
					aStream nextPutAll:' uninitialized'. ^ self ].
	rows 
		do: [ :each | each printOn: aStream]
		separatedBy: [ aStream cr].