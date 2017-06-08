initialization
initializeColumns: anArray

	| nRows nCols |
	nRows := (anArray at: 1) size.
	nCols := anArray size.
	
	rows := (1 to: nRows) collect: [ :i |
		DataSeries new: nCols ].
	
	1 to: nCols do: [ :j |
		1 to: nRows do: [ :i |
			(rows at: i) at: j put:
				((anArray at: j) at: i) ] ].