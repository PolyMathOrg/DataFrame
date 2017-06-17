initialization
initializeColumns: anArray

	| nRows nCols |
	nRows := (anArray at: 1) size.
	nCols := anArray size.
	
	1 to: nRows do: [ :i |
		| series |
		series := DataSeries new: nCols named: i.
		self add: series ].
	
	1 to: nCols do: [ :j |
		1 to: nRows do: [ :i |
			self at: i at: j put:
				((anArray at: j) at: i) ] ].