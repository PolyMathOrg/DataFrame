tests
testRowAt

	| actualRow expectedRow |
	
	actualRow := df rowAt: 2.
	expectedRow := #('Dubai' 2.789 true).
	
	self assert: actualRow equals: expectedRow.