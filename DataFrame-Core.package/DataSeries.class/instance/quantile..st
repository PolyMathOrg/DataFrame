statistics
quantile: number
	
	| sortedSeries index |
	sortedSeries := self asArray sort asDataSeries.
	
	number = 0
		ifTrue: [ ^ sortedSeries first ].
	
	index := (sortedSeries size * (number / 100)) ceiling.
	^ sortedSeries at: index.