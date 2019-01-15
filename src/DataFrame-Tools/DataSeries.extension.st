Extension { #name : #DataSeries }

{ #category : #'*DataFrame-Tools' }
DataSeries >> barplot [

	^ self barplotWithColor: DataColor blue.
]

{ #category : #'*DataFrame-Tools' }
DataSeries >> barplotWithColor: color [
	| uniqueValues points barWidth padding b ds |
	
	self isQuantitative not
		ifTrue: [ Error signal: 'Variable ', name asString, ' is not quantitative. Only quantitative variables can be plotted' ].
	
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
]

{ #category : #'*DataFrame-Tools' }
DataSeries >> boxplot [

	^ self boxplotWithColor: DataColor green.
]

{ #category : #'*DataFrame-Tools' }
DataSeries >> boxplotWithColor: color [

	| b ds |
	
	b := RTGrapher new.
	b extent: 100 @ 300.
	
	ds := RTBoxPlotDataSet new.
	ds points: self asArray.
		
	ds boxShape
		fillColor: color.
			
	ds outlierShape
		size: 5;
		fillColor: (color alpha: 0.5).
			
	b add: ds.
	
	b axisX
		noLabel;
		noTick.
	b build.
	^ b
]

{ #category : #'*DataFrame-Tools' }
DataSeries >> gtInspectorBoxplotIn: composite [
	<gtInspectorPresentationOrder: 0>
	<gtInspectorTag: #basic>
	
	composite roassal2
		title: 'Boxplot';
		initializeView: [ self boxplot ]
]

{ #category : #'*DataFrame-Tools' }
DataSeries >> gtInspectorScatterplotIn: composite [
	<gtInspectorPresentationOrder: 1>
	<gtInspectorTag: #basic>
	
	composite roassal2
		title: 'Scatterplot';
		initializeView: [ self scatterplot ]
]

{ #category : #'*DataFrame-Tools' }
DataSeries >> histogram [

	| numberOfUnique |
	
	numberOfUnique := self unique size.

	^ numberOfUnique <= 4
		ifTrue: [
			self histogramWithColors:
				(DataColor palette: numberOfUnique) ]
	 	ifFalse: [
			self histogramWithColor:
				DataColor blue ]
]

{ #category : #'*DataFrame-Tools' }
DataSeries >> histogram: binSize color: color [

	| sortedSeries aggregationKeys aggregatedSeries |
	
	sortedSeries := self asArray sort asDataSeries.
	
	aggregationKeys := (sortedSeries keys asDataSeries + (binSize - 1)) // binSize.
	aggregatedSeries := (sortedSeries groupBy: aggregationKeys) sum.
	
	aggregatedSeries keys: (((aggregatedSeries keys - 1) * binSize) + 1).
	
	^ aggregatedSeries histogramWithColor: color
]

{ #category : #'*DataFrame-Tools' }
DataSeries >> histogramWithColor: aColor [
	
	^ self histogramWithColors: (self collect: [ :v | aColor ]).
]

{ #category : #'*DataFrame-Tools' }
DataSeries >> histogramWithColors: colors [

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
]

{ #category : #'*DataFrame-Tools' }
DataSeries >> meanplot [

	^ self meanplotWithColor: DataColor green.
]

{ #category : #'*DataFrame-Tools' }
DataSeries >> meanplotWithColor: color [

	| b ds |

	b := RTGrapher new.
	b extent: 300 @ 200.
	ds := RTData new.
	ds noDot.
	ds points: self.
	ds connectColor: color.
	b add: ds.
	b addDecorator: RTMeanDevVarDecorator new.
	^ b
]

{ #category : #'*DataFrame-Tools' }
DataSeries >> plot [

	^ self plotWithColor: DataColor blue.
]

{ #category : #'*DataFrame-Tools' }
DataSeries >> plotWithColor: color [

	| b ds |

	b := RTGrapher new.
	b extent: 300 @ 200.
	ds := RTData new.
	ds noDot.
	ds points: self.
	ds connectColor: color.
	b add: ds.
	^ b
]

{ #category : #'*DataFrame-Tools' }
DataSeries >> scatterplot [
	
	^ self scatterplotWithColor: ((DataColor purple) alpha: 0.8).
]

{ #category : #'*DataFrame-Tools' }
DataSeries >> scatterplotWithColor: color [
	
	| b ds |
	
	((self type == Number) or:
	(self type inheritsFrom: Number))
		ifFalse: [ Error signal: 'This operation is not permitted for non-numeric series' ].
	
	b := RTGrapher new.
	b extent: 300 @ 200.
	
	ds := RTData new.
	ds dotShape circle color: color.
	ds points: self.
	b add: ds.
	
	^ b
]
