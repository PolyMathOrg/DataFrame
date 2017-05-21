tests
testInstanceCreationRows

	self shouldnt: [ 
		DataFrame rows: {
			{ 'Robb Stark' . 3 . true } .
    		{ 'Jon Snow' . Float nan . true } .
      		{ 'Eddard Stark' . 1 . true } }.
	] raise: MessageNotUnderstood.