accessing
columnsAt: anArray

	| names |
	
	names := anArray collect: [ :i |
		columnNames at: i ].
	
	^ self columns: names.