tests
testCollect

	| dfInternal dfActual dfExpected |
	
	dfInternal := DataFrameInternal fromRows:
		#((1 2)(3 4)(5 6)).
		
	dfExpected := DataFrameInternal fromRows:
		#((10 20)(30 40)(50 60)).
		
	dfActual := dfInternal
		collect: [ :each |
			each * 10 ].
		
	self assert: dfActual equals: dfExpected