accessing
at: rowNumber at: columnNumber put: value

	| typeInductor |
	
	contents at: rowNumber at: columnNumber put: value.

	typeInductor := DataTypeInductor new.
	columnTypes at: columnNumber put:
		(typeInductor
			leastCommonSuperclassOf: value class
			and: (columnTypes at: columnNumber)).