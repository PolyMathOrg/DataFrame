initialization
testSelectWhereGroupbyAggregate

	| selectedCols actual expected |
	
	selectedCols := #(petal_width petal_length).
	
	actual := df select: #(sepal_length species)
		where: [ :petal_length :petal_width |
			(petal_length < 4.9 and: petal_length > 1.6) and:
			(petal_width < 0.4 or: petal_width > 1.5) ]
		groupBy: #species
		aggregate: #sum.
		
	expected := DataFrame fromColumns: #((15.9 18.2 17.1)).
	expected columnNames: #(sepal_length).
	expected rowNames: #(setosa versicolor virginica).

	self assert: actual closeTo: expected.