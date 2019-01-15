*DataFrame-Tools
histogram: binSize color: color

	| sortedSeries aggregationKeys aggregatedSeries |
	
	sortedSeries := self asArray sort asDataSeries.
	
	aggregationKeys := (sortedSeries keys asDataSeries + (binSize - 1)) // binSize.
	aggregatedSeries := (sortedSeries groupBy: aggregationKeys) sum.
	
	aggregatedSeries keys: (((aggregatedSeries keys - 1) * binSize) + 1).
	
	^ aggregatedSeries histogramWithColor: color