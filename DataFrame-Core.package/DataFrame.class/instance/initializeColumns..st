initialization
initializeColumns: anArray

	| nRows nCols |
	nRows := (anArray at: 1) size.
	nCols := anArray size.
	
	(anArray first isKindOf: DataSeries)
		ifTrue: [ self columnNames: anArray first keys ]
		ifFalse: [ self columnNames: (1 to: nCols) ].
	
	1 to: nRows do: [ :i |
		| series |
		series := DataSeries new: nCols named: i.
		self at: i put: series ].
	
	1 to: nCols do: [ :j |
		1 to: nRows do: [ :i |
			self at: i at: j put:
				((anArray at: j) at: i) ] ].