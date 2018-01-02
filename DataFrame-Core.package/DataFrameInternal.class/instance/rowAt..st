accessing
rowAt: aNumber

	^ (1 to: self numberOfColumns) collect: [ :j |
		self at: aNumber at: j ].