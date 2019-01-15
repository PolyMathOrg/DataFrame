initialization
initializeMatrix: aMatrix

	contents := DataFrameInternal fromMatrix: aMatrix.
	self setDefaultRowColumnNames.
	self induceColumnTypes.