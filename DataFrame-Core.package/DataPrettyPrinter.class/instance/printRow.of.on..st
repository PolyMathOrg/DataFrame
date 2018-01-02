printing
printRow: aNumber of: aDataFrame on: aStream

	| row key |
	row := aDataFrame rowAt: aNumber.
	key := (aDataFrame rowNames at: aNumber) asString.
	self printRow: row andKey: key on: aStream.