tests
testColumn

	| actualSeries expectedSeries |

	expectedSeries := DataSeries fromArray:
		#('Barcelona' 'Dubai' 'London').
	
	expectedSeries name: #City.
	expectedSeries keys: df rowNames.
	
	actualSeries := df column: #City.
	
	self assert: actualSeries equals: expectedSeries.