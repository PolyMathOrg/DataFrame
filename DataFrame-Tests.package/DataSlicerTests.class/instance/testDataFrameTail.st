tests
testDataFrameTail

	| df slice dfExpected |
	df := DataFrame rows: 
		((1 to: 20) collect: [ :i |
			{ i * 10 . i * 100 } ]).
	
	slice := df tail.

	self assert: (slice isKindOf: DataFrame).
	self assert: slice size equals: df defaultHeadTailSize.
	
	dfExpected := DataFrame rows:
		((df size - df defaultHeadTailSize + 1 to: df size)
			collect: [ :i |
				{ i * 10 . i * 100 } ]).
	
	dfExpected keys: (df size - df defaultHeadTailSize + 1 to: df size).
			
	self assert: slice equals: dfExpected.