accessing
keyAtValue: value ifAbsent: exceptionBlock

	| index |
	index := contents indexOf: value.
	
	index = 0
		ifTrue: [ ^ exceptionBlock value ]
		ifFalse: [ ^ keys at: index ].