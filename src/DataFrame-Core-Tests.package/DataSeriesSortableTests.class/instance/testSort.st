tests
testSort
"Should sort this series into ascending order using the '<=' operator. Keys should be reordered together with elements"

	| expected |
	
	series sort.
	
	expected := #(1 1 2 2 2 3 3 4 5 5 5) asDataSeries.
	expected keys: #(e k b g j a f c d h i).
	expected name: series name.
	
	self assert: series equals: expected.