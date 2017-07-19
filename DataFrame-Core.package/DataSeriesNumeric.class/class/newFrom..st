instance creation
newFrom: anArray
"Every subclass of DataSeries overrides this method and converts the data to a specific type"
	
	| series |
	series := self new: (anArray size).
	
	anArray doWithIndex: [ :each :i |
		series at: i put: each asNumber ].
		
	^ series
	