comparing
= otherSeries

	"I'm not sure if names should be considered when testing for equality"
	self name = otherSeries name
		ifFalse: [ ^ false ].
		
	self type = otherSeries type
		ifFalse: [ ^ false ].
		
	self keys = otherSeries keys
		ifFalse: [ ^ false ].

	^ (1 to: self size) inject: true into: [ :allEqual :i |
		allEqual and: ((self at: i) = (otherSeries at: i)) ].