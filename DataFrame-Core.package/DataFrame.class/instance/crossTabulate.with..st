accessing
crossTabulate: colName1 with: colName2

	| col1 col2 |
	
	col1 := self column: colName1.
	col2 := self column: colName2.
	
	^ col1 crossTabulateWith: col2.