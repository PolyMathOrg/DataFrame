tests
testColumnAccessByName

	| actualSeries expectedSeries |
	
	expectedSeries := #(Barcelona Dubai London) asDataSeries.
	expectedSeries name: #City.
	expectedSeries keys: df rowNames.
	
	actualSeries := df column: #City.
	
	self assert: actualSeries equals: expectedSeries.