as yet unclassified
deduceType

	| convertedSeries numSeries |
	
	[ convertedSeries := self collect: [ :v | v asNumber ].
		"this will be executed if all the elements
		can be converted to a number"
		
		numSeries := DataSeriesNumeric new: self size.
		
		convertedSeries keysAndValuesDo: [ :key :value | 
			numSeries at: key put: value ].
		
		^ numSeries.
	] ifError: [ "do nothing" ]
		