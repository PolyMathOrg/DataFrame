tests
testIsQuantitative

	| quantitative categorical |
	
	quantitative := #(1.609 2.789 8.788) asDataSeries.
	categorical := #(Male Female) asDataSeries.
	
	self assert: quantitative isQuantitative.
	self assert: categorical isQuantitative not.