adding
add: aDataSeries

	(self columnNames isEmpty)
		ifFalse: [ aDataSeries keys: self columnNames ].
		
	self at: aDataSeries name put: aDataSeries.