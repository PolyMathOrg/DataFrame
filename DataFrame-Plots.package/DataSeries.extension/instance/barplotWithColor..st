*DataFrame-Plots
barplotWithColor: color
	| barWidth b ds |
	
	b := RTGrapher new.
	"b extent: 350 @ 300."
	
	barWidth := (b extent x) / (self size).
	
	"Adding space between bars"
	barWidth := barWidth - (barWidth / 2).

	ds := RTData new.
	
	ds interaction popup.
	ds points: self.

	ds dotShape rectangle color: color.

	ds barShape
		color: color;
		width: barWidth.
	b add: ds.
	b axisX.
	b axisYWithNumberOfTicks: 4.
	^ b