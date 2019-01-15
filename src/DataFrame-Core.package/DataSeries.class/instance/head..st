accessing
head: aNumber

	| n |
	
	self size > aNumber
		ifTrue: [ n := aNumber ]
		ifFalse: [ n := self size ].
		
	^ self from: 1 to: n.