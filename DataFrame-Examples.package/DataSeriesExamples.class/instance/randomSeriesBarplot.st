as yet unclassified
randomSeriesBarplot
	
	| rand array series |
	rand := Random new.
	
	array := (1 to: 20) collect: [ :x |
		rand next ].
	
	series := array asDataSeries.
	series barplot.