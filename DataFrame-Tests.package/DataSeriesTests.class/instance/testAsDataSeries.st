tests
testAsDataSeries

	| aSeries |
	aSeries := #(a b c) asDataSeries.
	
	self assert: aSeries size equals: 3.
	self assert: aSeries asArray equals: #(a b c).