*DataFrame-Core
asDataSeries

	| seriesClass aSeries |

	self
		detect: [ :x | x isNumber not ]
		ifFound: [ seriesClass := DataSeries ]
		ifNone: [ seriesClass := DataSeriesNumeric ].
	
	aSeries := seriesClass new: self size.
	
	self doWithIndex: [:each :i | aSeries at: i put: each].
	^ aSeries

