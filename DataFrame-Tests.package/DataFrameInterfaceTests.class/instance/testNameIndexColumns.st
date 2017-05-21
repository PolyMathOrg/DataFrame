tests
testNameIndexColumns

	self shouldnt: [ 
		DataFrame new columns: #('Name' 'Allegiances' 'Nobility').
	] raise: MessageNotUnderstood.