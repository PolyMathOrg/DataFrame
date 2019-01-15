tests
testIsSortedBy

	| sortBlock sorted notSorted1 notSorted2 |
	
	sortBlock := [ :a :b | a > b ].
	
	sorted := #(5 4 3 2 1) asDataSeries.
	notSorted1 := #(5 5 3 2 1) asDataSeries.
	notSorted2 := #(3 2 5 1 5) asDataSeries.
	
	self assert: (sorted isSortedBy: sortBlock).
	self assert: (notSorted1 isSortedBy: sortBlock) not.
	self assert: (notSorted2 isSortedBy: sortBlock) not.