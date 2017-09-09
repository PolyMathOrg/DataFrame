statistics
firstQuartile
	
	self isQuantitative not
		ifTrue: [ Error signal: 'Variable ', name asString, ' is not quantitative. Arythmetic and statistical operations can only be applied to quantitative variables' ].
	
	^ self quartile: 1