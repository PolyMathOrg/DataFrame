accessing
induceColumnTypeAt: aNumber
"Indeces the least common superclass for all values of a column of given by its number"

	| inductor type |
	inductor := DataTypeInductor new.
	type := inductor typeOf: (self columnAt: aNumber).
	
	columnTypes at: aNumber put: type.