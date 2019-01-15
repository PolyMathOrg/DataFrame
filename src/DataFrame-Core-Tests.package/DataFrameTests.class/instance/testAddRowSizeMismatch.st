tests
testAddRowSizeMismatch

	| aBlock |
	aBlock := [ df addRow: #(1 2) named: #TooSmall ].
	
	self should: aBlock raise: SizeMismatch.