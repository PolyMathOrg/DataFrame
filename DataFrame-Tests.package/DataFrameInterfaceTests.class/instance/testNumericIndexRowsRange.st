tests
testNumericIndexRowsRange

	self shouldnt: [
		DataFrame new rowsFrom: 2 to: 4.
	] raise: MessageNotUnderstood.