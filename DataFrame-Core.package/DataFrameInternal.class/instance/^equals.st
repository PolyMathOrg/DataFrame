comparing
= other

	((other class == self class
		or: [other isKindOf: Matrix])
		and: [ other numberOfRows = self numberOfRows 
		and: [ other numberOfColumns = self numberOfColumns]])
		ifFalse: [ ^ false ].
		
	other withIndicesDo: [ :each :i :j |
		(self at: i at: j) = each
			ifFalse: [ ^ false ] ].
		
	^ true

	
	