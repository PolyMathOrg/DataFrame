tests
testInstanceCreationRows

	| df |
	
	df := DataFrame rows: #(
		('Robb Stark' 3 true)
    	('Jon Snow' 4 true)
      	('Eddard Stark' 1 true)).
	
	df columnNames: #('Name' 'Book of Death' 'Nobility').
	
	self assert: (df column: #Name)
		equals: #('Robb Stark' 'Jon Snow' 'Eddard Stark') asDataSeries.
		
	self assert: (df column: 'Book of Death')
		equals: #(3 4 1) asDataSeries.
		
	self assert: (df column: #Nobility)
		equals: #(true true true) asDataSeries.