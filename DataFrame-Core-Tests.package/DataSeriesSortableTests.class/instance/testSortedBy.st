tests
testSortedBy
"Should return a new series which contains the same elements as self but its elements are sorted using the given sortBlock. Keys should be reordered together with elements. The initial series should not be affected"

	| sortBlock actual expected |
	
	sortBlock := [ :a :b | a >= b ].
	actual := series sorted: sortBlock.
	
	expected := #(5 5 5 4 3 3 2 2 2 1 1) asDataSeries.
	expected keys: #(d h i c a f b g j e k).
	expected name: series name.
	
	self assert: actual equals: expected.
	self assert: (series isSortedBy: sortBlock) not.