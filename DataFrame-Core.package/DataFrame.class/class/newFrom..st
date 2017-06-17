instance creation
newFrom: aDictOrCollection
	
	| df |
	
	(aDictOrCollection isKindOf: Dictionary)
		ifTrue: [ ^ super newFrom: aDictOrCollection ].
		
	df := self new.
	
	aDictOrCollection do: [ :series |
		df at: series name put: series ].
	
	^ df
		
	