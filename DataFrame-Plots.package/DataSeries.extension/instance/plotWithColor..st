*DataFrame-Plots
plotWithColor: color

	| b ds |

	b := RTGrapher new.
	b extent: 300 @ 200.
	ds := RTData new.
	ds noDot.
	ds points: self.
	ds connectColor: color.
	b add: ds.
	^ b