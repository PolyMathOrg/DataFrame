accessing
columnAt: aNumber

	^ (1 to: self numberOfRows) collect: [ :i |
		self at: i at: aNumber ]