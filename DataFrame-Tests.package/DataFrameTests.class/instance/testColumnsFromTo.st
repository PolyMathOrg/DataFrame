tests
testColumnsFromTo

	| actualDataFrame expectedDataFrame |
		
	expectedDataFrame := DataFrame fromRows: #(
		(1.609 true)
   		(2.789 true)
   		(8.788 false)).
		
	expectedDataFrame rowNames: df rowNames.
	expectedDataFrame columnNames: #(Population SomeBool).
	
	actualDataFrame := df columnsFrom: 2 to: 3.
	
	self assert: actualDataFrame equals: expectedDataFrame.