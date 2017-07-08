tests
testRowAccessByName

	| actualSeries expectedSeries |
	
	expectedSeries := #('Dubai' 2.789 true) asDataSeries.
	expectedSeries name: #B.
	expectedSeries keys: df columnNames.
	
	actualSeries := df row: #B.
	
	self assert: actualSeries equals: expectedSeries.