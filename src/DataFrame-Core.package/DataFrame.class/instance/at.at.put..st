accessing
at: rowNumber at: columnNumber put: value

	contents at: rowNumber at: columnNumber put: value.
	self induceColumnTypeAt: columnNumber.