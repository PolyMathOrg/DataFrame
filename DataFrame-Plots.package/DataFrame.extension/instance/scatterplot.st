*DataFrame-Plots
scatterplot

	| n palette b ds |
	
	n := self numericColumnNames size.
	palette := DataColor palette: n.
	
	b := RTGrapher new.
	b extent: 300 @ 300.
	
	(self numericColumnNames) doWithIndex: [ :columnName :i |
		ds := RTData new.
		ds dotShape circle color: ((palette at: i) alpha: 0.8).
		ds points: (self column: columnName).
		b add: ds ].
	
	^ b