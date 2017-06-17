enumerating
select: aBlock with: anArray
	
	( anArray size = 1 ) ifTrue: [ 
		^ self select: [ :row | 
			aBlock value: (row at: (anArray at: 1)) ] ].
	
	( anArray size = 2 ) ifTrue: [ 
		^ self select: [ :row | 
			aBlock
				value: (row at: (anArray at: 1)) 
				value: (row at: (anArray at: 2)) ] ].
		
	( anArray size = 3 ) ifTrue: [ 
		^ self select: [ :row | 
			aBlock
				value: (row at: (anArray at: 1)) 
				value: (row at: (anArray at: 2))
				value: (row at: (anArray at: 3)) ] ].
		
	Error signal: 'Too many arguments'.