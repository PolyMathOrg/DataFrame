statistics
mode

	| valueCounts maxCount |
	
	self signalErrorIfNotQuantitative.
	
	valueCounts := (self groupBy: self) count.
	maxCount := valueCounts max.
	
	^ valueCounts keyAtValue: maxCount.