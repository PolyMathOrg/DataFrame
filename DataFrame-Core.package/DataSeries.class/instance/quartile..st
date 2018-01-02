statistics
quartile: number
	
	self signalErrorIfNotQuantitative.
	^ self quantile: (25 * number)