enumerating
collectWithIndex: aBlock

	^ self class fromArray: 
		(contents collectWithIndex: aBlock).