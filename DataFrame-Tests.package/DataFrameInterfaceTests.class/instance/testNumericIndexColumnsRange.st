tests
testNumericIndexColumnsRange

	self shouldnt: [
		DataFrame new columnsFrom: 2 to: 4.
	] raise: MessageNotUnderstood.