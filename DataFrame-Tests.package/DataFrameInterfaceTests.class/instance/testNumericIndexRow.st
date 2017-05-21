tests
testNumericIndexRow

	self shouldnt: [
		DataFrame new rowAt: 1.
	] raise: MessageNotUnderstood.