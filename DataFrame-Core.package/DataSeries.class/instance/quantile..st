statistics
quantile: number
	
	| sortedSeries index |
	
	self isQuantitative not
		ifTrue: [ Error signal: 'Variable ', name asString, ' is not quantitative. Arythmetic and statistical operations can only be applied to quantitative variables' ].
	
	sortedSeries := self asArray sort asDataSeries.
	
	number = 0
		ifTrue: [ ^ sortedSeries first ].
	
	index := (sortedSeries size * (number / 100)) ceiling.
	^ sortedSeries at: index.