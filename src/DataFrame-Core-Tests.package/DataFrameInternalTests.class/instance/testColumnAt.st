tests
testColumnAt

	| actualColumn expectedColumn |
	
	actualColumn := df columnAt: 2.
	expectedColumn := #(1.609 2.789 8.788).
	
	self assert: actualColumn equals: expectedColumn.