comparing
= aDataFrame

	((aDataFrame species = self species)
		and: [ self columnNames = aDataFrame columnNames
		and: [ self keys = aDataFrame keys
		and: [ self size = aDataFrame size ]]])
	ifFalse: [ ^ false ].
	
	1 to: self size do: [ :i |
		((self rowAt: i) = (aDataFrame rowAt: i))
			ifFalse: [ ^ false ] ].
	
	^ true