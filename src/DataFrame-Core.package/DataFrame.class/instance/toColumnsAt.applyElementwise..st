applying
toColumnsAt: arrayOfColumnNumbers applyElementwise: aBlock
		
	arrayOfColumnNumbers do: [ :each |
		self toColumnAt: each applyElementwise: aBlock ].