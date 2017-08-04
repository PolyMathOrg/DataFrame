comparing
= otherSeries

	"I'm not sure if names should be considered when testing for equality"
	self name = otherSeries name
		ifFalse: [ ^ false ].
		
	self keys = otherSeries keys
		ifFalse: [ ^ false ].

	^ super = otherSeries