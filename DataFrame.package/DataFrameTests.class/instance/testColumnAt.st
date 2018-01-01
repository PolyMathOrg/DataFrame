tests
testColumnAt

	| actualSeries expectedSeries |

	expectedSeries := DataSeries fromArray:
		#('Barcelona' 'Dubai' 'London').
	
	expectedSeries name: #City.
	expectedSeries keys: df rowNames.
	
	actualSeries := df columnAt: 1.
	
	self assert: actualSeries equals: expectedSeries.