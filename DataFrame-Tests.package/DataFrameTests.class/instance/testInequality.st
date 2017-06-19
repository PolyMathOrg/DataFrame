tests
testInequality

	| df1 df2 |
	
	df1 := DataFrame rows: #((1 2)(3 4)).
	df1 keys: #(a b).
	
	df2 := DataFrame rows: #((1 2)(3 4)).
	df2 keys: #(c d).

	self assert: (df1 = df2) not.