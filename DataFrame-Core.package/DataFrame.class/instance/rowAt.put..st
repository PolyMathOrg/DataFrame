accessing
rowAt: aNumber put: anArray

	| typeInductor |
	anArray size = self numberOfColumns
		ifFalse: [ SizeMismatch signal ].
		
	contents rowAt: aNumber put: anArray.
	
	typeInductor := DataTypeInductor new.
	columnTypes := (1 to: self numberOfColumns) collect: [ :j |
		typeInductor
			leastCommonSuperclassOf: (columnTypes at: j)
			and: (anArray at: j) class. ].