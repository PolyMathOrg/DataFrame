accessing
columnAt: aNumber

	| series |
	
	series := (self collect: [ :row |
			row at: aNumber ]) asDataSeries.
		
	^ series name: (columnNames at: aNumber).