enumerating
collect: aBlock

	^ self class fromArray: 
		(contents collect: aBlock).