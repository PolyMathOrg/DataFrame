tests
testReplaceFromToWithArray

	| replacement expected |
	
	replacement := #(x y z).
	
	expected := #(10 20 x y z 60 70 80 90 100) asDataSeries.
	expected keys: keyArray.
	expected name: series name.
	
	series replaceFrom: 3 to: 5 with: replacement.
	
	self assert: series equals: expected.