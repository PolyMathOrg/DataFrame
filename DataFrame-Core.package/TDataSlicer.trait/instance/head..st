accessing
head: aNumber

	| n |
	
	( self size > aNumber )
		ifTrue: [ n := aNumber ]
		ifFalse: [ n := self size ].
		
	^ self class newFrom: (
		(1 to: n) collect: [ :i | self at: i ]).