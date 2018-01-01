comparing
= otherSeries

	(otherSeries isKindOf: DataSeries)
		ifFalse: [ ^ false ].

	"I'm not sure if names should be considered when testing for equality"
	self name = otherSeries name
		ifFalse: [ ^ false ].
		
	self type = otherSeries type
		ifFalse: [ ^ false ].
		
	self keys = otherSeries keys
		ifFalse: [ ^ false ].

	^ (1 to: self size) inject: true into: [ :allEqual :i |
		| selfCell otherCell |
		selfCell := self at: i.
		otherCell := otherSeries at: i.
		
		(allEqual and: (selfCell = otherCell))
			ifTrue: [ true ]
			ifFalse: [ 
				(selfCell isNumber and: otherCell isNumber)
					ifFalse: [ false ]
					ifTrue: [ (selfCell isNaN and: otherCell isNaN) ] ] ].