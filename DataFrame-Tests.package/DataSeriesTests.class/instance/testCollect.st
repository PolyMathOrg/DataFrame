tests
testCollect

	| actual expected |
	
	actual := series collect: [ :each |
		each / 10 ].
	
	expected := (1 to: 10) asDataSeries.
	expected name: series name.
	
	self assert: actual equals: expected.