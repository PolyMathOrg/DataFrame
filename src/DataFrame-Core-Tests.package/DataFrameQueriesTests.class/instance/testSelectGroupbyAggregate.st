initialization
testSelectGroupbyAggregate

	| selectedCols actual expected |
	selectedCols := #(petal_length petal_width).
	
	actual := df
		select: selectedCols
		groupBy: #species
		aggregate: #sum.
	
	expected := DataFrame fromRows: #(
		(73.2 12.2)
		(213.0 66.3)
		(277.6 101.3)).
		
	expected columnNames: selectedCols.
	expected rowNames: #(setosa versicolor virginica).
	
	self assert: actual closeTo: expected.