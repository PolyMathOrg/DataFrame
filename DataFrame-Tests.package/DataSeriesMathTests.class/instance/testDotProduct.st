tests
testDotProduct
"In PolyMath a * b is a dot product and a dot: b is an elementwise multiplication"

	| a b c |
	
	a := #(1 2 3) asDataSeries.
	b := #(2 3 4) asDataSeries.
	c := 20.
	
	self assert: (a * b) equals: c.