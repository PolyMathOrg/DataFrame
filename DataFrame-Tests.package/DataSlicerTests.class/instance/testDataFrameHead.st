tests
testDataFrameHead

	| df slice dfExpected |
	df := DataFrame rows: 
		((1 to: 20) collect: [ :i |
			{ i * 10 . i * 100 } ]).
	
	slice := df head.

	self assert: (slice isKindOf: DataFrame).
	self assert: slice size equals: df defaultHeadTailSize.
	
	dfExpected := DataFrame rows:
		((1 to: df defaultHeadTailSize)
			collect: [ :i |
				{ i * 10 . i * 100 } ]).
			
	self assert: slice equals: dfExpected.