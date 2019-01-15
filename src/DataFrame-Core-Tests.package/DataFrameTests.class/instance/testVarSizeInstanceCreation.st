tests
testVarSizeInstanceCreation

	| df |
	df := DataFrame new: 3@2.
	
	self assert: df numberOfRows equals: 3.
	self assert: df numberOfColumns equals: 2.
	
	self assert: df rowNames equals: #(1 2 3).
	self assert: df columnNames equals: #(1 2).