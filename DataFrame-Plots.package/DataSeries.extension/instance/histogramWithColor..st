*DataFrame-Plots
histogramWithColor: aColor
	
	^ self histogramWithColors: (self unique collect: [ :v | aColor ]).