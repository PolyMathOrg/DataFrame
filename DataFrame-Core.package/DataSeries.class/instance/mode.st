statistics
mode

	| valueCounts maxCount |
	
	valueCounts := (self groupBy: self) count.
	maxCount := valueCounts max.
	
	^ valueCounts indexOf: maxCount.