tests
testDo

	| dfInternal sum |
	
	dfInternal := DataFrameInternal fromRows:
		#((1 2)(3 4)(5 6)).
		
	sum := 0.
	
	dfInternal do: [ :each |
		sum := sum + each ].
	
	self assert: sum equals: 21.