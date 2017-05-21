tests
testNameIndexChain

	self shouldnt: [ 
		DataFrame new
			rows: #('Jon Snow' 'Eddard Stark');
   	 		columns: #('Name' 'Allegiances' 'Nobility').
	] raise: MessageNotUnderstood.