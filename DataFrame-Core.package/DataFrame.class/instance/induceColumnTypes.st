as yet unclassified
induceColumnTypes
"Indeces the least common superclass for all the values in each column of a data frame"

	| inductor |
	inductor := DataTypeInductor new.
	
	columnTypes := inductor columnTypesOf: self.