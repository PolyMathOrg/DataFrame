tests
testRowAt

	| actualSeries expectedSeries |

	expectedSeries := DataSeries fromArray:
		#('Dubai' 2.789 true).
		
	expectedSeries name: #B.
	expectedSeries keys: df columnNames.
	
	actualSeries := df rowAt: 2.
	
	self assert: actualSeries equals: expectedSeries.