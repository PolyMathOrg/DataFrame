tests
testRow

	| actualSeries expectedSeries |

	expectedSeries := DataSeries fromArray:
		#('Dubai' 2.789 true).
		
	expectedSeries name: #B.
	expectedSeries keys: df columnNames.
	
	actualSeries := df row: #B.
	
	self assert: actualSeries equals: expectedSeries.