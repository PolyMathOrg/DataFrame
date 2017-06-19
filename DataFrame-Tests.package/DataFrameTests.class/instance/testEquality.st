tests
testEquality

	| df1 df2 |
	
	df1 := DataFrame rows: #((1 2)(3 4)).
	df2 := DataFrame rows: #((1 2)(3 4)).
	
	self assert: df1 equals: df2.
	self assert: (df1 = df2).