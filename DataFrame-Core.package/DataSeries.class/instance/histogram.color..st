as yet unclassified
histogram: barSize color: color

	| aggregationKeys aggregatedSeries |
	
	aggregationKeys := self keys asDataSeries % (self size / barSize).
	aggregatedSeries := (self groupBy: aggregationKeys) sum.
	
	^ aggregatedSeries histogramWithColor: color