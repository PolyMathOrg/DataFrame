tests
testIsCategorical

	| quantitative categorical |
	
	quantitative := #(1.609 2.789 8.788) asDataSeries.
	categorical := #(Male Female) asDataSeries.
	
	self assert: quantitative isCategorical not.
	self assert: categorical isCategorical.