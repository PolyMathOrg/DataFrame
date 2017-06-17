initialization
initializeRows: anArray

	anArray doWithIndex: [ :row :i | 
		| series |
		series := row asDataSeries.
		self add: (series name: i) ].
	
	columnNames := ((1 to: (anArray first) size)
		collect: [ :i | i asString ]) asDataSeries.