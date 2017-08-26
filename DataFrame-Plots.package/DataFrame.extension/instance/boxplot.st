*DataFrame-Plots
boxplot

	| b ds n palette color |

	n := self numericColumnNames size.
	
	b := RTGrapher new.
	b extent: (n * 70) @ 300.
	
	palette := DataColor palette: n.
	
	(self numericColumnNames) doWithIndex: [ :columnName :i |
		ds := RTBoxPlotDataSet new.
		ds points: (self column: columnName) asArray.
		
		color := palette at: i.
		
		ds boxShape
			fillColor: color.
			
		ds outlierShape
			size: 5;
			fillColor: (color alpha: 0.5).
			
		b add: ds ].
	
	b axisX
		noLabel;
		noTick.
	b build.
	^ b