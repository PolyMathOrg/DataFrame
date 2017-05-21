tests
testNumericIndexColumn

	self shouldnt: [
		DataFrame new columnAt: 2.
	] raise: MessageNotUnderstood.