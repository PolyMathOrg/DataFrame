statistics
mode

	| valueCounts maxCount |
	
	self isQuantitative not
		ifTrue: [ Error signal: 'Variable ', name asString, ' is not quantitative. Arythmetic and statistical operations can only be applied to quantitative variables' ].
	
	valueCounts := (self groupBy: self) count.
	maxCount := valueCounts max.
	
	^ valueCounts keyAtValue: maxCount.