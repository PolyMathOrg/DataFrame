private
apply: aBlock

	| result |
	
	result := groups collect: [ :eachGroup |
		aBlock value: eachGroup ].
	
	result := result asDataSeries.
	result keys: groups keys.
	
	^ result