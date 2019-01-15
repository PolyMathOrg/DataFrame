tests
testRowsAt

	| rowNumbers actualDataFrame expectedDataFrame |
	
	rowNumbers := #(1 3).
	
	expectedDataFrame := DataFrame fromRows: #(
		('Barcelona' 1.609 true)
   		('London' 8.788 false)).
		
	expectedDataFrame rowNames:
		(rowNumbers collect: [ :i |
			df rowNames at: i ]).
	expectedDataFrame columnNames: df columnNames.
	
	actualDataFrame := df rowsAt: rowNumbers.
	
	self assert: actualDataFrame equals: expectedDataFrame.