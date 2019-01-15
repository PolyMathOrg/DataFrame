accessing
rowAt: aNumber put: anArray

	anArray size = self numberOfColumns
		ifFalse: [ SizeMismatch signal ].
		
	contents rowAt: aNumber put: anArray.
	self induceColumnTypes.