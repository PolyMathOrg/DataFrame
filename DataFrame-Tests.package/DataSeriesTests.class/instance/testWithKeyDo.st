tests
testWithKeyDo

	| sum |
	sum := 0.
	
	series withKeyDo: [ :each :key |
		sum := sum + (each / key) ].
	
	self assert: sum equals: 100.