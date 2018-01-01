comparing
closeTo: aDataFrame

	aDataFrame species = self species
		ifFalse: [ ^ false ].
	
	aDataFrame dimensions = self dimensions
		ifFalse: [ ^ false ].
		
	aDataFrame columnTypes = self columnTypes
		ifFalse: [ ^ false ].
		
	(aDataFrame rowNames = self rowNames
		and: [ aDataFrame columnNames = self columnNames ])
		ifFalse: [ ^ false ].
		
	1 to: self numberOfRows do: [ :i |
		1 to: self numberOfColumns do: [ :j |
			((self at: i at: j) closeTo: (aDataFrame at: i at: j))
				ifFalse: [ ^ false ] ] ].
	
	^ true