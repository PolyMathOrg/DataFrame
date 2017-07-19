*DataFrame-Core
asDataSeries

	| allInstancesOf |
	
	allInstancesOf := [ :aClass |
		self detect: [ :x |
			(x isKindOf: aClass) not ]
			ifFound: [ false ]
			ifNone: [ true ] ].

	(allInstancesOf value: Number) ifTrue: [ 
		^ DataSeriesNumeric newFrom: self ].
	
	(allInstancesOf value: String) ifTrue: [ 
		"Can we convert it to DataSeriesTime?"
		[ ^ DataSeriesTime newFrom: self ]
			on: Error do: [ "nothing" ] ].
		
	"Either everything is a String, or none of the above is satisfied. In any case, we convert everything to String"
	^ DataSeriesText newFrom: self 

