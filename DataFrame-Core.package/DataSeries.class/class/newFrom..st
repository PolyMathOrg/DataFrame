instance creation
newFrom: aCollection
	
	| df |
	
	((aCollection isKindOf: Dictionary) or:
	 (aCollection isKindOf: OrderedDictionary))
		ifTrue: [ ^ super newFrom: aCollection ].
		
	"If all the values are associations"
	aCollection
		detect: [ :each |
			(each isKindOf: Association) not ]
		ifNone: [ ^ super newFrom: aCollection ].
		
		
	df := self new.
	
	aCollection doWithIndex: [ :value :i |
		df at: i put: value ].
	
	^ df
		
	