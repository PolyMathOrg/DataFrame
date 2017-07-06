adding
add: anArrayOrSeries

	| aDataSeries |
	aDataSeries := anArrayOrSeries asDataSeries.
	
	(self columnNames isEmpty)
		ifFalse: [ aDataSeries keys: self columnNames ].
		
	self at: aDataSeries name put: aDataSeries.