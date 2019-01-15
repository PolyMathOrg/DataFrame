removing
removeRowAt: rowNumber

	contents removeRowAt: rowNumber.
	rowNames := rowNames copyWithoutIndex: rowNumber.
	self induceColumnTypes.