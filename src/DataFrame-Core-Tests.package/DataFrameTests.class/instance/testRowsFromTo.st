tests
testRowsFromTo

	| actualDataFrame expectedDataFrame |
		
	expectedDataFrame := DataFrame fromRows: #(
   		('Dubai' 2.789 true)
   		('London' 8.788 false)).
		
	expectedDataFrame rowNames: #(B C).
	expectedDataFrame columnNames: df columnNames.
	
	actualDataFrame := df rowsFrom: 2 to: 3.
	
	self assert: actualDataFrame equals: expectedDataFrame.