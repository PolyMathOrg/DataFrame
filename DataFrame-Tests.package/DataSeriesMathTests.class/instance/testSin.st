tests
testSin

	| a b pi |
	
	pi := Float pi.
	a := { 0 . pi . pi/2 . pi/4 . pi/6 } asDataSeries.
	b := { 0 . 0 . 1 . 1/2 sqrt . 1/2 } asDataSeries.
	
	self assert: a sin closeTo: b.