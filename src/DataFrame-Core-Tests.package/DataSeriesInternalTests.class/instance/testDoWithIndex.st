initialization
testDoWithIndex

	| sum |
	sum := 0.
	
	series doWithIndex: [ :each :i |
		sum := sum + (each / i) ].
	
	self assert: sum equals: 100.