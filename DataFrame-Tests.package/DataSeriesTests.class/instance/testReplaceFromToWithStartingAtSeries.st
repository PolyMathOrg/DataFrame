tests
testReplaceFromToWithStartingAtSeries

	| replacement expected |
	
	replacement := #(a b c d e) asDataSeries.
	replacement keys: #(k1 k2 k3 k4 k5).
	replacement name: #Replacement.
	
	expected := #(10 20 b c d 60 70 80 90 100) asDataSeries.
	expected keys: #(a b k2 k3 k4 f g h i j).
	expected name: series name.
	
	series replaceFrom: 3 to: 5 with: replacement startingAt: 2.
	
	self assert: series equals: expected.