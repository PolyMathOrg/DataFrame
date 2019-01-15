*DataFrame-Tools
histogramWithColor: aColor
	
	^ self histogramWithColors: (self collect: [ :v | aColor ]).