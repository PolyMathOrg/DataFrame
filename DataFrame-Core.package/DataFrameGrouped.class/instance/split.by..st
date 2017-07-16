private
split: aDataFrame by: aSeries

	| seriesUnique |
	
	aDataFrame numberOfRows = aSeries size
		ifFalse: [ SizeMismatch signal ].
	
	seriesUnique := aSeries unique asArray.
	
	groups := seriesUnique collect: [ :eachUnique |
		| aList df |
		aList := LinkedList new.
		
		aSeries doWithIndex: [ :each :i |
			each = eachUnique 
				ifTrue: [ aList add: (aDataFrame rowAt: i) ] ].
		
		df := DataFrame fromRows: aList.
		df columnNames: aDataFrame columnNames.
		df ].
	
	groups := groups asDataSeries.
	groups keys: seriesUnique.
	
	^ self