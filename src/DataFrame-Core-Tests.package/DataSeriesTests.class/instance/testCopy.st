tests
testCopy

	| seriesCopy expectedOriginal expectedCopy |
	
	expectedOriginal := #(10 20 30 40 50 60 70 80 90 100) asDataSeries.
	expectedOriginal keys: keyArray.
	expectedOriginal name: series name.
		
	expectedCopy := #(10 20 30 40 50 -2 70 80 100 -3) asDataSeries.
	expectedCopy keys: ((keyArray copyWithout: #i) copyWith: #X).
	expectedCopy name: #ChangedName.
	
	seriesCopy := series copy.
	seriesCopy at: 6 put: -2.
	seriesCopy removeAtKey: #i.
	seriesCopy add: -3 atKey: #X.
	seriesCopy name: #ChangedName.
	
	self assert: series equals: expectedOriginal.
	self assert: seriesCopy equals: expectedCopy.