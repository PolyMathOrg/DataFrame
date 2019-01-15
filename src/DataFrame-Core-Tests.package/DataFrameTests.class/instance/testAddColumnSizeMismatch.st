tests
testAddColumnSizeMismatch

	| aBlock |
	aBlock := [ df addColumn: #(1 2 3 4) named: #TooBig ].
	
	self should: aBlock raise: SizeMismatch.