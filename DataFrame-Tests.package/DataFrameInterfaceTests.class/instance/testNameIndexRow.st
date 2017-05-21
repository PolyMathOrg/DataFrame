tests
testNameIndexRow

	self shouldnt: [
		DataFrame new row: 'Jon Snow'.
	] raise: MessageNotUnderstood.