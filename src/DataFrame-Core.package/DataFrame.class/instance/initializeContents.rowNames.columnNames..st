initialization
initializeContents: aDataFrameInternal rowNames: rows columnNames: columns

	super initialize.
	
	contents := aDataFrameInternal.
	self rowNames: rows.
	self columnNames: columns.
	self induceColumnTypes.