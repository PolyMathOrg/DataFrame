tests
testDataFrameTail

	| actual expected rows |
	
	expected := DataFrame fromRows: #(
		(6.7 3 5.2 2.3 virginica)
		(6.3 2.5 5 1.9 virginica)
		(6.5 3 5.2 2 virginica)
		(6.2 3.4 5.4 2.3 virginica)
		(5.9 3 5.1 1.8 virginica)).
	expected columnNames: df columnNames.
	
	rows := df numberOfRows.
	expected rowNames:
		(rows - df defaultHeadTailSize + 1 to: rows).
	
	actual := df tail.
			
	self assert: actual equals: expected.