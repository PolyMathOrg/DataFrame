private
applyToQuantitativeColumns: aSymbol
"Sends the unary selector, aSymbol, to all the quantitative columns of DataFrame and collects the result into a DataSeries object. Used by statistical functions of DataFrame"

	| series column |
	
	series := DataSeries fromArray:
		(self columnNames collect: [ :colName |
			column := self column: colName.
			
			column isQuantitative
				ifTrue: [ column perform: aSymbol ]
				ifFalse: [ Float nan ] ]).
	
	series name: aSymbol.
	series keys: self columnNames.
	
	^ series