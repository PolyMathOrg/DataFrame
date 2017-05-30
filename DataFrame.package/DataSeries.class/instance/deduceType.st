as yet unclassified
deduceType

	| convertedSeries |
	
	[ convertedSeries := self collect: [ :v | v asNumber ].
		"this will be executed if all the elements
		can be converted to a number"
		
		convertedSeries doWithIndex: [ :v :i | 
			self at: i put: v ].
		
	] ifError: [ "do nothing" ]
		