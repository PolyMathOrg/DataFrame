tests
testColumnsAt

	| columnNumbers dfActual dfExpected |
	
	columnNumbers := #(1 3).
	
	dfExpected := DataFrameInternal fromRows: #(
		('Barcelona' true)
   		('Dubai' true)
   		('London' false)).
		
	dfActual := df columnsAt: columnNumbers.
	
	self assert: dfActual equals: dfExpected.