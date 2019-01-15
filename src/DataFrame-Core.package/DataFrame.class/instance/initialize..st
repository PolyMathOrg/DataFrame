initialization
initialize: aPoint

	super initialize.
	
	contents := DataFrameInternal new: aPoint.
	self setDefaultRowColumnNames.
	self induceColumnTypes.