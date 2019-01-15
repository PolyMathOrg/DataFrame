adding
addRow: anArray named: rowName

	contents addRow: anArray.
	rowNames := rowNames copyWith: rowName.
	self induceColumnTypes.