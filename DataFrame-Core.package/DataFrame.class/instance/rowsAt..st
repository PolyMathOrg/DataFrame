accessing
rowsAt: anArray

	^ DataFrame rows: (anArray collect: [ :i | 
		rows at: i ]).