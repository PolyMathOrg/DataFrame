accessing
head: aNumber

	| n |
	
	self numberOfRows  > aNumber
		ifTrue: [ n := aNumber ]
		ifFalse: [ n := self numberOfRows ].
		
	^ self rowsAt: (1 to: n).