converting
keys: anArray

	| values |

	(anArray size = self size)
		ifFalse: [ SizeMismatch signal ].
		
	"Check if all values are unique"
	(anArray asSet size = anArray size)
		ifFalse: [ Error signal: 'All keys must be unique' ].
	
	values := self values.
	self removeAll.
		
	anArray doWithIndex: [ :newKey :i |
		self at: newKey put: (values at: i) ].