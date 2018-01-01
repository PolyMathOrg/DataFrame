initialization
testCollect

	| expected actual |
	
	expected := (1 to: 10) asArray.
	actual := series collect: [ :each | each / 10 ].

	self assert: expected equals: actual.