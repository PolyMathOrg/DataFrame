tests
testWithIndicesDo

	| dfInternal |
	
	dfInternal := DataFrameInternal fromRows:
		#((1 2)(3 4)(5 6)).
		
	dfInternal withIndicesDo: [ :each :i :j |
		self assert: each equals: ((i - 1) * 2 + j) ].