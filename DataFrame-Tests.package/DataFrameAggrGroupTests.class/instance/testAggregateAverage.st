initialization
testAggregateAverage

	| expected actual |
	
	expected := #(20.79 18.3433) asDataSeries.
	expected keys: #(Female Male).
	
	actual := (df group: #total_bill by: #sex) average.
	
	self assert: actual closeTo: expected.