tests
testAtIfAbsent

	self assert: (series at: 2) equals: 20.
	
	self assert: (series at: 100 ifAbsent: [ 'Executing a block' ])
		equals: 'Executing a block'.