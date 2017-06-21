*DataFrame-Plots
boxplotWithColor: color

	| b ds |
	
	b := RTGrapher new.
	b extent: 100 @ 300.
	
	ds := RTBoxPlotDataSet new.
	ds points: self values.
		
	ds boxShape
		fillColor: color.
			
	ds outlierShape
		size: 5;
		fillColor: (color alpha: 0.5).
			
	b add: ds.
	
	b axisX
		noLabel;
		noTick.
	b build.
	^ b