initialization
testGroupbyAggregate

	| actual expected |
	
	actual := df groupBy: #species aggregate: #sum.
	
	expected := DataFrame fromRows: #(
		(250.3 170.9 73.2 12.2)
		(296.8 138.5 213.0 66.3)
		(329.4 148.7 277.6 101.3)).
		
	expected columnNames: #(sepal_length sepal_width petal_length petal_width).
	expected rowNames: #(setosa versicolor virginica).
	
	self assert: actual closeTo: expected.