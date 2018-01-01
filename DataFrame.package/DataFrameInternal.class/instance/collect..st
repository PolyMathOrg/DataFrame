enumerating
collect: aBlock

	^ self class fromMatrix:
		(contents collect: aBlock).