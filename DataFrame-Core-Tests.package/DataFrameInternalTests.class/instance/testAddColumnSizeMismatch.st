tests
testAddColumnSizeMismatch
	
	| aBlock |
	aBlock := [ df addColumn: #(1 2 3 4) ].
	
	self should: aBlock raise: SizeMismatch.
	
