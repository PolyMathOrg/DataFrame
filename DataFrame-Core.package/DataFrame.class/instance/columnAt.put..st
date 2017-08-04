accessing
columnAt: aNumber put: anArray

	anArray size = self numberOfRows
		ifFalse: [ SizeMismatch signal ].
		
	contents columnAt: aNumber put: anArray.