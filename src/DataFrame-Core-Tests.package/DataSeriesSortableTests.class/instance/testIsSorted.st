tests
testIsSorted

	| sorted notSorted |
	
	sorted := #(1 2 3 5 5) asDataSeries.
	notSorted := #(3 2 5 1 5) asDataSeries.
	
	self assert: sorted isSorted.
	self assert: notSorted isSorted not.