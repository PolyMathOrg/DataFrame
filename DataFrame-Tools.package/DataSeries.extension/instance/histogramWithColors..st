*DataFrame-Tools
histogramWithColors: colors

	| points barWidth padding b ds |
	
	"uniqueValues := self unique.
	
	points := uniqueValues collect: [ :v |
		(uniqueValues indexOf: v) @ (self occurrencesOf: v) ]."
	
	points := (1 to: self size) collect: [ :i |
		(self keys at: i) @ (self at: i) ].
	
	b := RTGrapher new.
	"b extent: 350 @ 300."
	
	"In case we want to start x axis from 0"
	"nonemptyWidth := (b extent x) - ((uniqueValues min) * ((b extent x) / (uniqueValues max))).
	barWidth := nonemptyWidth / (uniqueValues size)."
	barWidth := (b extent x) / (self size).
	
	"Adding space between bars"
	barWidth := barWidth - (barWidth / 2.5).

	ds := RTData new.
	
	ds interaction popup.
	ds points: points.
	ds x: [ :point | point x ].
	ds y: [ :point | point y ].

	ds dotShape rectangle color: [ :point | colors atKey: point x ].

	ds barShape
		color: [ :point | colors atKey: point x ];
		width: barWidth.
		
	ds barChartWithBarCenteredTitle: [ :point | point x ].
		
	b add: ds.
	
	padding := 0.5.
	b minX: 0 + padding.
	b maxX: self size + padding.
	
	b withoutOrigin.
	
	b axisX
		"labelConversion: [ :i | uniqueValues at: i ];"
		noTick;
		noLabel.
		
	b axisY
		numberOfTicks: 5.
	
	^ b