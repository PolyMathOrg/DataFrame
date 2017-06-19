instance creation
newFrom: aDictOrCollection
	
	| df |
	
	((aDictOrCollection isKindOf: Dictionary) or:
	 (aDictOrCollection isKindOf: OrderedDictionary))
		ifTrue: [ ^ super newFrom: aDictOrCollection ].
		
	df := self new.
	
	aDictOrCollection doWithIndex: [ :value :i |
		df at: i put: value ].
	
	^ df
		
	