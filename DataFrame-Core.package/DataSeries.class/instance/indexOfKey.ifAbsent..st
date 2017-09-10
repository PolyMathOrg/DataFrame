private
indexOfKey: aKey ifAbsent: aBlock

	| index |
	index := keys indexOf: aKey.
	
	index = 0
		ifTrue: [ ^ aBlock value ].
		
	^ index