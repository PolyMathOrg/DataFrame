accessing
atKey: aKey put: aValue

	| index |
	index := keys indexOf: aKey.
	
	index = 0
		"a key was not found - create a new element"
		ifTrue: [
			keys := keys copyWith: aKey.
			contents add: aValue ]
		"a key was found - update the value"
		ifFalse: [
			self at: index put: aValue ].