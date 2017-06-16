initialization
initializeColumns: anArray

	| nRows nCols |
	nRows := (anArray at: 1) size.
	nCols := anArray size.
	
	nRows timesRepeat: [
		self add: (DataSeries new: nCols) ].
	
	1 to: nCols do: [ :j |
		1 to: nRows do: [ :i |
			self at: i at: j put:
				((anArray at: j) at: i) ] ].