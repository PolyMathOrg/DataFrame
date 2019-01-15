tests
testAt

	| actual expected |

	expected := DataSeries fromArray:
		#('Dubai' 2.789 true).
		
	expected name: #B.
	expected keys: df columnNames.
	
	actual := df at: 2.
	
	self assert: actual equals: expected.