tests
testCollectWithIndex

	| actual expected |
	
	actual := series collectWithIndex: [ :each :i |
		each / 10 + i ].
	
	expected := (2 to: 20 by: 2) asDataSeries.
	
	self assert: actual equals: expected.