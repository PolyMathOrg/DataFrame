tests
testInstanceCreationColumns

	self shouldnt: [ 
		DataFrame columns: {
			'Name' -> { 'Robb Stark' . 'Jon Snow' . 'Eddard Stark' } .
   			'Book of Death' -> { 3 . Float nan . 1 } .
    		'Nobility' -> { true . true . true } } asDictionary.
	] raise: MessageNotUnderstood.