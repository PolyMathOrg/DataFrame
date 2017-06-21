*DataFrame-Plots
histogramWithColors: colors

	| uniqueValues points barWidth padding b ds |
	
	uniqueValues := self unique.
	
	points := uniqueValues collect: [ :v |
		(uniqueValues indexOf: v) @ (self occurrencesOf: v) ].
	
	b := RTGrapher new.
	"b extent: 350 @ 300."
	
	"In case we want to start x axis from 0"
	"nonemptyWidth := (b extent x) - ((uniqueValues min) * ((b extent x) / (uniqueValues max))).
	barWidth := nonemptyWidth / (uniqueValues size)."
	barWidth := (b extent x) / (uniqueValues size).
	
	"Adding space between bars"
	barWidth := barWidth - (barWidth / 2.5).

	ds := RTData new.
	
	ds interaction popup.
	ds points: points.
	ds x: [ :point | point x ].
	ds y: [ :point | point y ].

	ds dotShape rectangle color: [ :point | colors at: point x ].

	ds barShape
		color: [ :point | colors at: point x ];
		width: barWidth.
		
	ds barChartWithBarCenteredTitle: [ :point | uniqueValues at: point x ].
		
	b add: ds.
	
	padding := 0.5.
	b minX: 0 + padding.
	b maxX: uniqueValues size + padding.
	
	b withoutOrigin.
	
	b axisX
		"labelConversion: [ :i | uniqueValues at: i ];"
		noTick;
		noLabel.
		
	b axisY
		numberOfTicks: 5.
	
	^ b