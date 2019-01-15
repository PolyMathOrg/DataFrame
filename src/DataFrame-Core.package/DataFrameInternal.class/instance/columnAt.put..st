accessing
columnAt: aNumber put: anArray
"Sets all the values of a given column equal to the values in array. It is assumed that array is of the same size as every column (number of rows). This should be tested in DataFrame"

	(1 to: self numberOfRows) do: [ :i |
		self at: i at: aNumber put: (anArray at: i) ].