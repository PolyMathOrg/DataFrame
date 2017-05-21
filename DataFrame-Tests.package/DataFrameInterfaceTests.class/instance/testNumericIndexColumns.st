tests
testNumericIndexColumns

	self shouldnt: [
		DataFrame new columnsAt: #(4 5 2 1).
	] raise: MessageNotUnderstood.