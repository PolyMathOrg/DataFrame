adding
add: aValue atKey: aKey

	contents add: aValue.
	keys := keys copyWith: aKey.
	self induceTypeWithNewElement: aValue.