initialization
testCollectWithIndex

	| expected actual |
	
	expected := (1 to: 10) collect: [ :k | k * 2 ].
	actual := series collectWithIndex: [ :each :i |
		each / 10 + i ].

	self assert: expected equals: actual.