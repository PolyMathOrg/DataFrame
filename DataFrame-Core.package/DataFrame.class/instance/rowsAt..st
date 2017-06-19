accessing
rowsAt: anArray

	| df |
	df := DataFrame rows: (anArray collect: [ :i | 
		self rowAt: i ]).
	
	df keys: (anArray collect: [ :i |
		self keys at: i ]).
	
	^ df