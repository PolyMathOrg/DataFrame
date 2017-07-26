*DataFrame-Plots
scatterplotWithColor: color
	
	| b ds |
	
	b := RTGrapher new.
	b extent: 300 @ 200.
	
	ds := RTData new.
	ds dotShape circle color: color.
	ds points: self.
	b add: ds.
	
	^ b