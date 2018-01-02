tests
testDataFrameHead

	| actual expected |
	
	expected := DataFrame fromRows: #(
		(5.1 3.5 1.4 0.2 setosa)
		(4.9 3 1.4 0.2 setosa)
		(4.7 3.2 1.3 0.2 setosa)
		(4.6 3.1 1.5 0.2 setosa)
		(5 3.6 1.4 0.2 setosa)).
	expected columnNames: df columnNames.
	expected rowNames: (1 to: df defaultHeadTailSize).
	
	actual := df head.
			
	self assert: actual equals: expected.