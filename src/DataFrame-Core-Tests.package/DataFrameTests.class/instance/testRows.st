tests
testRows

	| rowNames actualDataFrame expectedDataFrame |
	
	rowNames := #(A C).
	
	expectedDataFrame := DataFrame fromRows: #(
		('Barcelona' 1.609 true)
   		('London' 8.788 false)).
		
	expectedDataFrame rowNames: rowNames.
	expectedDataFrame columnNames: df columnNames.
	
	actualDataFrame := df rows: rowNames.
	
	self assert: actualDataFrame equals: expectedDataFrame.