*DataFrame-Plots
histogram

	| numberOfUnique |
	
	numberOfUnique := self unique size.

	^ numberOfUnique <= 4
		ifTrue: [
			self histogramWithColors:
				(DataColor palette: numberOfUnique) ]
	 	ifFalse: [
			self histogramWithColor:
				DataColor blue ]