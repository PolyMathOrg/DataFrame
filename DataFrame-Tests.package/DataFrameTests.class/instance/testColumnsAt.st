tests
testColumnsAt

	| columnNumbers actualDataFrame expectedDataFrame |
	
	columnNumbers := #(1 3).
	
	expectedDataFrame := DataFrame fromRows: #(
		('Barcelona' true)
   		('Dubai' true)
   		('London' false)).
		
	expectedDataFrame rowNames: df rowNames.
	expectedDataFrame columnNames:
		(columnNumbers collect: [ :i |
			df columnNames at: i ]).
	
	actualDataFrame := df columnsAt: columnNumbers.
	
	self assert: actualDataFrame equals: expectedDataFrame.