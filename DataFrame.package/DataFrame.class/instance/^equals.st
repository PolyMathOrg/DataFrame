comparing
= aDataFrame

	"Most objects will fail here"
	aDataFrame species = self species
		ifFalse: [ ^ false ].
	
	"This is the fastest way for two data frames with different dimensions"
	aDataFrame dimensions = self dimensions
		ifFalse: [ ^ false ].
		
	"If column types are different, we don't need to iterate through row and column names"
	aDataFrame columnTypes = self columnTypes
		ifFalse: [ ^ false ].
	
	"If the names are different we don't need to iterate through values"	
	(aDataFrame rowNames = self rowNames
		and: [ aDataFrame columnNames = self columnNames ])
		ifFalse: [ ^ false ].
		
	^ aDataFrame contents = self contents.