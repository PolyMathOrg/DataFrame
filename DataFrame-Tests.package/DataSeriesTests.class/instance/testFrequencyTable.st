tests
testFrequencyTable

	| aSeries expected |
	aSeries := #(A B C A A B C A B B) asDataSeries.
	
	expected := DataFrame fromColumns: {
		{ 4 . 4 . 2 } .
		{ 2/5 . 2/5 . 1/5 }}.
		
	expected rowNames: #(A B C).
	expected columnNames: #(Count Proportion).
	
	self assert: aSeries frequencyTable equals: expected