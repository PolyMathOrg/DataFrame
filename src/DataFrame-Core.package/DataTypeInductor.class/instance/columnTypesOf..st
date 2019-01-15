as yet unclassified
columnTypesOf: aDataFrame
"Induces the column types of a data frame"

	| allClasses |
	
	^ (1 to: aDataFrame numberOfColumns) collect: [ :j |
		allClasses := Set new.
		
		1 to: aDataFrame numberOfRows do: [ :i | 
			allClasses add: (aDataFrame at: i at: j) class ].
		
		self leastCommonSuperclassOf: allClasses asArray. ].