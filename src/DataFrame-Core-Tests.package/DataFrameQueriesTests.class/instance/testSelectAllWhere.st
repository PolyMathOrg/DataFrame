initialization
testSelectAllWhere

	| actual |
	
	actual := df selectAllWhere: [ :species :sepal_width |
		species = #setosa and: sepal_width = 3 ].
	
	self assert: actual columnNames equals: df columnNames.
	self assert: actual rowNames equals: #(2 13 14 26 39 46).