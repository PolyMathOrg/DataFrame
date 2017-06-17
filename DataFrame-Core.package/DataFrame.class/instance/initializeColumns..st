initialization
initializeColumns: anArray

	| nRows nCols |
	nRows := (anArray at: 1) size.
	nCols := anArray size.
	
	1 to: nRows do: [ :i |
		| series |
		series := DataSeries new: nCols named: i.
		series keys: self columnNames.
		self at: i put: series ].
	
	1 to: nCols do: [ :j |
		1 to: nRows do: [ :i |
			self at: i at: j put:
				((anArray at: j) at: i) ] ].