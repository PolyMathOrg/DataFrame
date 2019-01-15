applying
toColumns: arrayOfColumnNames applyElementwise: aBlock
		
	arrayOfColumnNames do: [ :each |
		self toColumn: each applyElementwise: aBlock ].