accessing
at: rowNumber at: columnNumber

	^ (self at: (self keys at: rowNumber))
		at: (self columnNames at: columnNumber).