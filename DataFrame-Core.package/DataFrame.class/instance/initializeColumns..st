initialization
initializeColumns: anArrayOfArrays

	contents := DataFrameInternal fromColumns: anArrayOfArrays.
	self setDefaultRowColumnNames.