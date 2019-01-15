accessing
rowAt: aNumber

	| series |
	series := (contents rowAt: aNumber) asDataSeries.
	series name: (self rowNames at: aNumber).
	series keys: self columnNames.
	^ series