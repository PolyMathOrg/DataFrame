statistics
frequencyTable

	| df count proportion |
	
	count := (self groupBy: self) count.
	proportion := count / self size.
	
	df := DataFrame fromColumns:
		{ count . proportion }.
		
	df rowNames: self unique asArray.
	df columnNames: #(Count Proportion).
	
	^ df