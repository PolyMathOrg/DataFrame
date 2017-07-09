as yet unclassified
frequencyTable

	| df count proportion |
	
	count := self unique collect: [ :each |
		self occurrencesOf: each ].
	
	proportion := count / self size.
	
	df := DataFrame fromColumns:
		{ count . proportion }.
		
	df rowNames: self unique asArray.
	df columnNames: #(Count Proportion).
	
	^ df