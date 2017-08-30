tests
testGroupSeriesBySeries

	| femaleGroup maleGroup expectedSeries actualSeries |
	
	femaleGroup := #(16.99 24.59) asDataSeries.
	maleGroup := #(10.34 21.01 23.68) asDataSeries.
	
	expectedSeries := { femaleGroup . maleGroup } asDataSeries.
	expectedSeries keys: #('Female' 'Male').
	
	actualSeries := (df group: #total_bill by: #sex) groups.
	
self assert: actualSeries equals: expectedSeries.