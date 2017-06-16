accessing
rowsAt: anArray

	^ DataFrame rows: (anArray collect: [ :i | 
		self rowAt: i ]).