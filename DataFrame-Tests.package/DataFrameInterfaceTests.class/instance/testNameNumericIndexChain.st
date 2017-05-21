tests
testNameNumericIndexChain

	self shouldnt: [
		DataFrame new
			columns: #('Name' 'Allegiances');
    		rowsAt: #(10 20 30 40).
	] raise: MessageNotUnderstood.