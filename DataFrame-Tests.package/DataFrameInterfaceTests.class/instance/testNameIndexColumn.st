tests
testNameIndexColumn

	self shouldnt: [ 
		DataFrame new column: 'Name'.
	] raise: MessageNotUnderstood.