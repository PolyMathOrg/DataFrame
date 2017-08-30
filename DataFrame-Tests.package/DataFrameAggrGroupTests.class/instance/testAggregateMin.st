initialization
testAggregateMin

	| expected actual |
	
	expected := #(16.99 10.34) asDataSeries.
	expected keys: #(Female Male).
	
	actual := (df group: #total_bill by: #sex) min.
	
	self assert: actual equals: expected.