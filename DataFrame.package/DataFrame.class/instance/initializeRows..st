initialization
initializeRows: anArray

	rows := anArray collect: [ :row | row asDataSeries ].
	
	columnNames := ((1 to: (rows  at: 1) size)
		collect: [ :i | i asString ]) asDataSeries.