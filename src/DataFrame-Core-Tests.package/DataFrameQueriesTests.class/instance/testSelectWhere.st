initialization
testSelectWhere

	| selectedCols actual |
	
	selectedCols := #(petal_width petal_length).
	
	actual := df
		select: selectedCols
		where: [ :species :sepal_width |
			species = #setosa and: sepal_width = 3 ].
	
	self assert: actual columnNames equals: selectedCols.
	self assert: actual rowNames equals: #(2 13 14 26 39 46).