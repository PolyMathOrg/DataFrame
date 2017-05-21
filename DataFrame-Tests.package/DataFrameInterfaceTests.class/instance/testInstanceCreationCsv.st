tests
testInstanceCreationCsv

	self shouldnt: [ 
		DataFrame readCsv: 'path/to/data'.
	] raise: MessageNotUnderstood.