tests
testWithIndexCollect

	| actual expected |
	
	actual := series collectWithIndex: [ :each :i |
		each / 10 + i ].
	
	expected := (2 to: 20 by: 2) asDataSeries.
	expected name: series name.
	
	self assert: actual equals: expected.