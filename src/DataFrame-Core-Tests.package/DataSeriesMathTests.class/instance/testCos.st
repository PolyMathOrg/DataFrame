tests
testCos

	| a b pi |
	
	pi := Float pi.
	a := { 0 . pi . pi/2 . pi/4 . pi/3 } asDataSeries.
	b := { 1.0 . -1.0 . 0.0 . 1/2 sqrt . 0.5 } asDataSeries.
	
	self assert: a cos closeTo: b.