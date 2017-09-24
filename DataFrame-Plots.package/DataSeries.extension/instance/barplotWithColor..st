*DataFrame-Plots
barplotWithColor: color

	| uniqueValues points barWidth padding b ds |
	
	uniqueValues := self unique.
	points := uniqueValues collect: [ :v |
		v @ (self occurrencesOf: v) ].
	
	b := RTGrapher new.
	"b extent: 350 @ 300."
	
	"In case we want to start x axis from 0"
	"nonemptyWidth := (b extent x) - ((uniqueValues min) * ((b extent x) / (uniqueValues max))).
	barWidth := nonemptyWidth / (uniqueValues size)."
	barWidth := (b extent x) / (uniqueValues size).
	
	"Adding space between bars"
	barWidth := barWidth - (barWidth / 3).

	ds := RTData new.
	
	ds interaction popup.
	ds points: points.
	ds x: [ :point | point x ].
	ds y: [ :point | point y ].

	ds dotShape rectangle color: color.

	ds barShape
		color: color;
		width: barWidth.
	b add: ds.
	
	padding := uniqueValues range / uniqueValues size / 1.5.
	b minX: self min - padding.
	b maxX: self max + padding.
	
	b withoutOrigin.
		
	b axisY
		numberOfTicks: 5.
	
	^ b