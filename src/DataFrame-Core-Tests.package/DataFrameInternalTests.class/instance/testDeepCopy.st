tests
testDeepCopy

	| dfCopy |
	
	dfCopy := df deepCopy.
	
	self assert: (df = dfCopy).
	self assert: (df == dfCopy) not.