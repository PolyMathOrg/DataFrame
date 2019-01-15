statistics
interquartileRange

	self signalErrorIfNotQuantitative.
	^ self thirdQuartile - self firstQuartile