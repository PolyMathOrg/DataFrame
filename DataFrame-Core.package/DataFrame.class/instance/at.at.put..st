accessing
at: rowNumber at: columnNumber put: val

	^ (self at: (self keys at: rowNumber))
		at: (self columnNames at: columnNumber)
		put: val.