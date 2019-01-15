removing
removeAtKey: aKey

	| index |
	index := self indexOfKey: aKey.
	self removeAt: index.