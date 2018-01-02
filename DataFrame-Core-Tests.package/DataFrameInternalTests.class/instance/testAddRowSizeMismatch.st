tests
testAddRowSizeMismatch
	
	| aBlock |
	aBlock := [ df addRow: #(1 2) ].
	
	self should: aBlock raise: SizeMismatch.
	
