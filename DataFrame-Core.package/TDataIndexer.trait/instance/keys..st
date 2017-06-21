converting
keys: anArray

	| values |

	"Check if all values are unique"
	(anArray asSet size = anArray size)
		ifFalse: [ Error signal: 'All keys must be unique' ].
		
	(self isEmpty)
		ifTrue: [ anArray doWithIndex: [ :key |
				self at: key put: nil ] ].

	(anArray size = self size)
		ifFalse: [ SizeMismatch signal ].
	
	values := self values.
	self removeAll.
		
	anArray doWithIndex: [ :newKey :i |
		self at: newKey put: (values at: i) ].