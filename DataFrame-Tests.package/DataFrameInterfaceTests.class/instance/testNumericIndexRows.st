tests
testNumericIndexRows

	self shouldnt: [
		DataFrame new rowsAt: #(1 3 2 7).
	] raise: MessageNotUnderstood.