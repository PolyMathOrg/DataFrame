accessing
tail: aNumber

	| n |
	
	( self size > aNumber )
		ifTrue: [ n := aNumber ]
		ifFalse: [ n := self size ].
			
	^ self class newFrom: (
		self from: (self size - n + 1) to: (self size)).