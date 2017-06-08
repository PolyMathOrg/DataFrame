enumerating
select: aBlock with: anArray

	| cols |
	cols := anArray collect: [ :name |
		columnNames indexOf: name ].
	
	( cols size = 1 ) ifTrue: [ 
		^ self select: [ :row | 
			aBlock value: (row at: (cols at: 1)) ] ].
	
	( cols size = 2 ) ifTrue: [ 
		^ self select: [ :row | 
			aBlock
				value: (row at: (cols at: 1)) 
				value: (row at: (cols at: 2)) ] ].
		
	( cols size = 3 ) ifTrue: [ 
		^ self select: [ :row | 
			aBlock
				value: (row at: (cols at: 1)) 
				value: (row at: (cols at: 2))
				value: (row at: (cols at: 3)) ] ].
		
	Error signal: 'Too many arguments'.