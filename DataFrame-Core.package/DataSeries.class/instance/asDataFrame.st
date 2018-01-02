converting
asDataFrame

	| df |
	df := DataFrame fromColumns: { self }.
	df columnNames: { self name }.
	df rowNames: self keys.
	^ df