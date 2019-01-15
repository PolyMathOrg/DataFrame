tests
testAsDataSeries

	| aSeries |
	aSeries := #(a b c) asDataSeries.
	
	self assert: aSeries size equals: 3.
	self assert: aSeries asArray equals: #(a b c).
	self assert: aSeries keys equals: #(1 2 3).