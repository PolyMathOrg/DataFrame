tests
testNameIndexRows

	self shouldnt: [
		DataFrame new rows: #('Jon Snow' 'Eddard Stark').
	] raise: MessageNotUnderstood.