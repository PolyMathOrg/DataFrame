accessing
rowAt: aNumber put: anArray
"Sets all the values of a given row equal to the values in array. It is assumed that array is of the same size as every row (number of columns). This should be tested in DataFrame"

	(1 to: self numberOfColumns) do: [ :j |
		self at: aNumber at: j put: (anArray at: j) ].