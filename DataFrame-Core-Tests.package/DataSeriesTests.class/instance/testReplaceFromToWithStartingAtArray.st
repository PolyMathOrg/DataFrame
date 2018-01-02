tests
testReplaceFromToWithStartingAtArray

	| replacement expected |
	
	replacement := #(a b c d e).
	
	expected := #(10 20 b c d 60 70 80 90 100) asDataSeries.
	expected keys: keyArray.
	expected name: series name.
	
	series replaceFrom: 3 to: 5 with: replacement startingAt: 2.
	
	self assert: series equals: expected.