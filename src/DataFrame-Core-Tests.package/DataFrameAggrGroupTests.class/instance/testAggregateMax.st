initialization
testAggregateMax

	| expected actual |
	
	expected := #(24.59 23.68) asDataSeries.
	expected keys: #(Female Male).
	
	actual := (df group: #total_bill by: #sex) max.
	
	self assert: actual equals: expected.