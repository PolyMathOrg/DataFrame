accessing
columnsAt: anArrayOfNumbers

	| newColumnNames |
	
	newColumnNames := (anArrayOfNumbers collect: [ :i |
		self columnNames at: i ]).

	^ DataFrame
		fromContents: (self contents columnsAt: anArrayOfNumbers)
		rowNames: self rowNames
		columnNames: newColumnNames.