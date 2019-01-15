comparing
= other

	((other class == self class
			or: [ other isKindOf: Array ])
			and: [ other size = self size ])
		ifFalse: [ ^ false ].
		
	1 to: self size do: [ :i |
		(self at: i) = (other at: i)
			ifFalse: [ ^ false ] ].
		
	^ true.
		