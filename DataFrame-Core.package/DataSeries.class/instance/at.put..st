accessing
at: aNumber put: value

	contents at: aNumber put: value.
	
	self type isNil
		"In case we fill the empty series with elements (e.g. collect)"
		ifTrue: [ type := value class ]
		
		"In case we add an element to the existing series"
		ifFalse: [ 
			| inductor |
			inductor := DataTypeInductor new.
			type := inductor
				leastCommonSuperclassOf: value class
				and: self type. ].