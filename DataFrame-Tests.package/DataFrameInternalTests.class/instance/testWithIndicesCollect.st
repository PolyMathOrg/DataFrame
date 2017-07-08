tests
testWithIndicesCollect

	| dfInternal actual expected |
	
	dfInternal := DataFrameInternal fromRows:
		#((1 2)(3 4)(5 6)).
		
	expected := DataFrameInternal fromRows:
		#((true true)(true true)(true true)).
		
	actual := dfInternal
		withIndicesCollect: [ :each :i :j |
			each = ((i - 1) * 2 + j) ].
		
	self assert: actual equals: expected