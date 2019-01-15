accessing
columnAt: aNumber

	| series |
	series := (contents columnAt: aNumber) asDataSeries.
	series name: (self columnNames at: aNumber).
	series keys: self rowNames.
	^ series