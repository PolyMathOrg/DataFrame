*DataFrame-Plots
histogramWithColors: colors

	| points barWidth b ds |
	
	"uniqueValues := self unique.
	
	points := uniqueValues collect: [ :v |
		(uniqueValues indexOf: v) @ (self occurrencesOf: v) ]."
	
	points := (1 to: self size) collect: [ :i |
		(self keys at: i) @ (self at: i) ].
	
	b := RTGrapher new.
	b extent: 300 @ 200.
	
	ds := RTData new.
	ds interaction popup.
	
	barWidth := (b extent x) / (self size).
	
	"Adding space between bars"
	barWidth := barWidth - (barWidth / 2.5).
	
	ds points: points.
	ds x: [ :point | point x ].
	ds y: [ :point | point y ].

	ds dotShape rectangle color: [ :point | colors atKey: point x ].

	ds barShape
		color: [ :point | colors atKey: point x ];
		width: barWidth.
		
	"ds barChartWithBarCenteredTitle: [ :point | point x ]."
		
	b add: ds.
	b axisX.
	
	^ b