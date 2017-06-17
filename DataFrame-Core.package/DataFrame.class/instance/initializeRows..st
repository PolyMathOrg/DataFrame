initialization
initializeRows: anArray

	anArray doWithIndex: [ :row :i | 
		| series |
		series := row asDataSeries.
		self add: (series name: i) ].
	
	self columnNames: (self at: 1) keys asDataSeries.