tests
testDataFrameHeadN

	| actual expected |
	
	expected := DataFrame fromRows: #(
		(5.1 3.5 1.4 0.2 setosa)
		(4.9 3 1.4 0.2 setosa)
		(4.7 3.2 1.3 0.2 setosa)).
	expected columnNames: df columnNames.
	expected rowNames: (1 to: 3).
	
	actual := df head: 3.
			
	self assert: actual equals: expected.