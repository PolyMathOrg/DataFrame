initialization
testAtPut

	| expected actual |
	
	expected := #(10 20 30 40 50 -2 70 80 90 100).
	actual := series at: 6 put: -2.
	
	self assert: expected equals: actual.