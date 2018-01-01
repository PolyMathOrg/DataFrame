as yet unclassified
typeOf: aSeries

	| allClasses |
	allClasses := Set new.
	
	aSeries do: [ :each |
		allClasses add: each class ].
	
	^ self leastCommonSuperclassOf: allClasses asArray.