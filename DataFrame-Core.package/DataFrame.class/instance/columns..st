accessing
columns: anArray
	
	| df |
	
	df := self class columns:
		(anArray collect: [ :name |
			(self column: name) ]).
		
	df columnNames: anArray.
	df rowNames: self rowNames.
	^ df