private
split: firstSeries by: secondSeries

	| secondUnique |
	
	firstSeries size = secondSeries size
		ifFalse: [ SizeMismatch signal ].
	
	secondUnique := secondSeries unique asArray.
	
	groups := secondUnique collect: [ :eachUnique |
		| aList |
		aList := LinkedList new.
		
		secondSeries doWithIndex: [ :eachSecond :i |
			eachSecond = eachUnique 
				ifTrue: [ aList add: (firstSeries at: i) ] ].
		
		aList asDataSeries ].
	
	groups := groups asDataSeries.
	groups keys: secondUnique.
	
	^ self