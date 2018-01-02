tests
testAtAtPut

	| expectedDataFrame |
	
	expectedDataFrame := DataFrame fromRows: #(
		('Barcelona' 1.609 true)
   		('Dubai' 2.789 true)
   		('London' 1000 false)).
		
	expectedDataFrame rowNames: df rowNames.
	expectedDataFrame columnNames: df columnNames.
		
	df at: 3 at: 2 put: 1000.
			
	self assert: df equals: expectedDataFrame. 