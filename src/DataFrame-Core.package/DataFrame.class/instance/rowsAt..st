accessing
rowsAt: anArrayOfNumbers

	| newRowNames |
	
	newRowNames := (anArrayOfNumbers collect: [ :i |
		self rowNames at: i ]).

	^ DataFrame
		fromContents: (self contents rowsAt: anArrayOfNumbers)
		rowNames: newRowNames
		columnNames: self columnNames.