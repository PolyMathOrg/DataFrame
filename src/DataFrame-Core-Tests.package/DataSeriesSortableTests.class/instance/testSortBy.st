tests
testSortBy
"Should sort this series using the given sortBlock. Keys should be reordered together with elements"

	| expected |
	
	series sort: [ :a :b | a >= b ].
	
	expected := #(5 5 5 4 3 3 2 2 2 1 1) asDataSeries.
	expected keys: #(d h i c a f b g j e k).
	expected name: series name.
	
	self assert: series equals: expected.