tests
testNumericIndexCell

	self shouldnt: [
		DataFrame new at: 3 at: 4.
	] raise: MessageNotUnderstood.