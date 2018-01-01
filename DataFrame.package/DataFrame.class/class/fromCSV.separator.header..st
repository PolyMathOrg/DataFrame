instance creation
fromCSV: pathToFile separator: separator header: containsHeader

	| stream arrayOfRows |
	
	stream := pathToFile asFileReference readStream.
	
	arrayOfRows := (NeoCSVReader on: stream)
		separator: separator;
		upToEnd.
		
	containsHeader ifTrue: [
		| df |
		"TODO: Make this faster"
		df := self fromRows: (arrayOfRows copyFrom: 2 to: arrayOfRows size).
		df columnNames: (arrayOfRows at: 1).
		^ df ].
	
	^ self fromRows: arrayOfRows.