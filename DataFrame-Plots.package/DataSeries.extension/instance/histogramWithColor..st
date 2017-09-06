*DataFrame-Plots
histogramWithColor: aColor
	
	^ self histogramWithColors: (self collect: [ :v | aColor ]).