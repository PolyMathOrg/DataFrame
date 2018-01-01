tests
testReplaceFromToWithSeries

	| replacement expected |
	
	replacement := #(x y z) asDataSeries.
	replacement keys: #(k1 k2 k3).
	replacement name: #Replacement.
	
	expected := #(10 20 x y z 60 70 80 90 100) asDataSeries.
	expected keys: #(a b k1 k2 k3 f g h i j).
	expected name: series name.
	
	series replaceFrom: 3 to: 5 with: replacement.
	
	self assert: series equals: expected.