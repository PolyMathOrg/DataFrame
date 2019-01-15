as yet unclassified
induceTypeWithNewElement: aValue
"Induces type of series given that the new element was added to it"

	self type isNil
		"In case we fill the empty series with elements (e.g. collect)"
		ifTrue: [ type := aValue class ]
		
		"In case we add an element to the existing series"
		ifFalse: [ 
			type := DataTypeInductor new
				leastCommonSuperclassOf: aValue class
				and: self type. ].