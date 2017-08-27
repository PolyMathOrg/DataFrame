accessing
at: aNumber put: aValue

	contents at: aNumber put: aValue.
	self induceTypeWithNewElement: aValue.