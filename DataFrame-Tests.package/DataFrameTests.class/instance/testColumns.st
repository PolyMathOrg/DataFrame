tests
testColumns

	| columnNames actualDataFrame expectedDataFrame |
	
	columnNames := #(City SomeBool).
	
	expectedDataFrame := DataFrame fromRows: #(
		('Barcelona' true)
   		('Dubai' true)
   		('London' false)).
		
	expectedDataFrame rowNames: df rowNames.
	expectedDataFrame columnNames: columnNames.
	
	actualDataFrame := df columns: columnNames.
	
	self assert: actualDataFrame equals: expectedDataFrame.