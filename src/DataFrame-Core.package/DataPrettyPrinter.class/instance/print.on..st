printing
print: aDataFrame on: aStream
"Pretty-prints a data frame"
	
	columnLengths := self eachColumnMaxLength: aDataFrame.
	columnAligns := self eachColumnAlign: aDataFrame.
	separator := '  '.
	
	self printRow: (aDataFrame columnNames) andKey: '' on: aStream.
	aStream cr.
	
	self printLineOn: aStream.
	aStream cr.
	
	1 to: aDataFrame numberOfRows do: [ :i |
		self printRow: i of: aDataFrame on: aStream.
		aStream cr ].