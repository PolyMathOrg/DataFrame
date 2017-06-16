initialization
initializeRows: anArray

	anArray do: [ :row | self add: row asDataSeries ].
	
	columnNames := ((1 to: (anArray first) size)
		collect: [ :i | i asString ]) asDataSeries.