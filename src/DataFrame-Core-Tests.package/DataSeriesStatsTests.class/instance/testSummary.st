tests
testSummary

	| expected |
	
	expected := #(3 7 9 10.45 15 20) asDataSeries.
	expected keys: #(Min '1st Qu.' Median Mean '3rd Qu.' Max).
	
	self assert: series summary equals: expected.