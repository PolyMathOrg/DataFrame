tests
testSorted
"Should return a new series which contains the same elements as self but its elements are sorted in ascending order using the #'<=' operator. Keys should be reordered together with elements. The initial series should not be affected"

	| actual expected |
	
	actual := series sorted.
	
	expected := #(1 1 2 2 2 3 3 4 5 5 5) asDataSeries.
	expected keys: #(e k b g j a f c d h i).
	expected name: series name.
	
	self assert: actual equals: expected.
	self assert: series isSorted not.