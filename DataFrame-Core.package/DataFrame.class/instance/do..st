enumerating
do: aBlock
"We enumerate through the data enrties - through rows of a data frame"

	1 to: self numberOfRows do: [ :i |
		aBlock value: (self rowAt: i) ].