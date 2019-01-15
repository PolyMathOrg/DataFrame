as yet unclassified
toCsv: path separator: sep

	| stream |
	
	stream := FileStream newFileNamed: path. 
	
	1 to: (columnNames size - 1) do: [ :i |
		stream
			nextPutAll: (columnNames at: i) asString;
		 	nextPutAll: sep ].
	
	stream
		nextPutAll: columnNames last asString;
		cr.
	
	self do: [ :row |
		1 to: (row size - 1) do: [ :i |
			stream
				nextPutAll: (row at: i) asString;
				nextPutAll: sep. ].
			
		stream
			nextPutAll: row last asString;
			cr ].
	stream close. 