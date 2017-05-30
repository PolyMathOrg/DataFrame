tests
testInstanceCreationColumns

	| df |
	
	df := DataFrame columns: #(
		('Robb Stark' 'Jon Snow' 'Eddard Stark')
   		(3 4 1)
    	(true true true)).
	
	df columnNames: #('Name' 'Book of Death' 'Nobility').
	
	self assert: (df column: #Name)
		equals: #('Robb Stark' 'Jon Snow' 'Eddard Stark') asDataSeries.
		
	self assert: (df column: 'Book of Death')
		equals: #(3 4 1) asDataSeries.
		
	self assert: (df column: #Nobility)
		equals: #(true true true) asDataSeries.