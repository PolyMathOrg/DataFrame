instance creation
fromSeries: aSeries
	
	| series |
	series := self newFrom: aSeries.
	
	series keys: aSeries keys.
	series name: aSeries name.
	
	^ series
		
	