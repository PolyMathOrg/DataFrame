initialization
initializeWithArray: anArray

	anArray isArray
		ifFalse: [ Error signal:
			'Only an instance of Array can be accepted as an argument' ].

	contents := anArray.
	^ self.