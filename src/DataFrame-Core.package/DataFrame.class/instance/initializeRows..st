initialization
initializeRows: anArrayOfArrays

	contents := DataFrameInternal fromRows: anArrayOfArrays.
	self setDefaultRowColumnNames.
	self induceColumnTypes.