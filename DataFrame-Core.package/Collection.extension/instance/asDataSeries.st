*DataFrame-Core
asDataSeries

	| seriesClass series |
	
	"If all the values are associations, we convert it to DataSeries the same way as the array of associations is converted to dictionary with asDictionary"
	self detect: [ :x |
			(x class = Association) not ]
		ifNone: [ | keys values |
			keys := self collect: [ :assoc |
				assoc key ].
			values := self collect: [ :assoc |
				assoc value ].
			
			series := values asDataSeries.
			series keys: keys.
			^ series ].

	self
		detect: [ :x | x isNumber not ]
		ifFound: [ seriesClass := DataSeries ]
		ifNone: [ seriesClass := DataSeriesNumeric ]. 
	
	series := seriesClass new: self size.
	
	self doWithIndex: [:each :i | series at: i put: each].
	^ series

