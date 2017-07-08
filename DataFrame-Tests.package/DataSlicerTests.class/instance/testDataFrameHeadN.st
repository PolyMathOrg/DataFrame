tests
testDataFrameHeadN

	| df slice dfExpected |
	df := DataFrame fromRows: 
		((1 to: 20) collect: [ :i |
			{ i * 10 . i * 100 } ]).
	
	slice := df head: 3.

	self assert: (slice isKindOf: DataFrame).
	
	dfExpected := DataFrame rows:
		((1 to: 3)
			collect: [ :i |
				{ i * 10 . i * 100 } ]).
			
	self assert: slice equals: dfExpected.