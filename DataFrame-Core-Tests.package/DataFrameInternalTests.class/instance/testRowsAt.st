tests
testRowsAt

	| rowNumbers dfActual dfExpected |
	
	rowNumbers := #(1 3).
	
	dfExpected := DataFrameInternal fromRows: #(
		('Barcelona' 1.609 true)
   		('London' 8.788 false)).
		
	dfActual := df rowsAt: rowNumbers.
	
	self assert: dfActual equals: dfExpected.