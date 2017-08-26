statistics
quantile: number
	
	| sortedSeries |
	sortedSeries := self asArray sort asDataSeries.
	
	sortedSeries size < 4
		ifTrue: [ ^ sortedSeries last ].
	
	^ sortedSeries at: (sortedSeries size * (number / 100)).