accessing
columnAt: aNumber put: anArray

	| typeInductor type |
	
	anArray size = self numberOfRows
		ifFalse: [ SizeMismatch signal ].
		
	typeInductor := DataTypeInductor new.
	type := typeInductor typeOf: anArray.	
	
	contents columnAt: aNumber put: anArray.
	columnTypes at: aNumber put: type.