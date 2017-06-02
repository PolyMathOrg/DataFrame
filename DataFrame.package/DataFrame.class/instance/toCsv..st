initialization
toCsv: path

	| stream |
	
	stream := FileStream newFileNamed: path. 
	
	1 to: (columnNames size - 1) do: [ :i |
		stream
			nextPutAll: (columnNames at: i) asString;
		 	nextPutAll: ',' ].
	
	stream
		nextPutAll: columnNames last asString;
		cr.
	
	rows do: [ :row |
		1 to: (row size - 1) do: [ :i |
			stream
				nextPutAll: (row at: i) asString;
				nextPutAll: ','. ].
			
		stream
			nextPutAll: row last asString;
			cr ].
	stream close. 