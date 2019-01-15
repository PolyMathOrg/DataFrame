tests
testInequality

	| df1 df2 df3 df4 df5 |
	
	"Other data frames will be compared to this one"
	df1 := DataFrame fromRows: #((1 2)(3 4)).
	df1 rowNames: #(a b).
	df1 columnNames: #(x y).
	
	"This one has different row names"
	df2 := DataFrame fromRows: #((1 2)(3 4)).
	df2 rowNames: #(c b).
	df2 columnNames: #(x y).
	
	"This one has different column names"
	df3 := DataFrame fromRows: #((1 2)(3 4)).
	df3 rowNames: #(a b).
	df3 columnNames: #(x z).
	
	"This one has different dimensions"
	df4 := DataFrame fromRows: #((1 2)(3 4)(5 6)).
	df4 rowNames: #(a b).
	df4 columnNames: #(x z).
	
	"This one has different values"
	df5 := DataFrame fromRows: #((1 2)(3 5)).
	df5 rowNames: #(a b).
	df5 columnNames: #(x z).

	self assert: (df2 = df1) not.
	self assert: (df3 = df1) not.
	self assert: (df4 = df1) not.
	self assert: (df5 = df1) not.