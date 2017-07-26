tests
testCollect

	| actual expected |
	
	actual := series collect: [ :each |
		each / 10 ].
	
	expected := (1 to: 10) asDataSeries.
	
	self assert: actual equals: expected.