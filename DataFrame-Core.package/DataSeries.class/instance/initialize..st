initialization
initialize: aNumber
"Creates an empty DataSeries of a given size. Keys are set to their default values"

	contents := DataSeriesInternal new: aNumber.
	self setDefaultKeys.
	^ self