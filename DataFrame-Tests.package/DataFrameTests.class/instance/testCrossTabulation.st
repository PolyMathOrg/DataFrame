tests
testCrossTabulation

	| df crossTab |
	
	df := DataFrame rows: #(
		(Male Young)
		(Female Old)
		(Female Young)
		(Female Young)
		(Male Old)).
	df columnNames: #(Gender Age).
	
	crossTab := df crossTabulate: #Gender with: #Age.
	
	self assert: (crossTab isKindOf: DataFrame).
	self assert: crossTab dimension equals: 2@2.