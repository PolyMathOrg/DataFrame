accessing
crossTabulate: colName1 with: colName2

	| col1 col2 series df crossSelect |
	
	col1 := self column: colName1.
	col2 := self column: colName2.
	
	df := self class new.
	
	col1 unique do: [ :eachCol1 |
		series := (col2 unique collect: [ :eachCol2 |
			crossSelect := self
				select: [ :x :y | x = eachCol1 and: y = eachCol2 ]
				with: { colName1 . colName2 }.
			crossSelect size. ]) asDataSeries.
		
		series name: eachCol1.
		df add: series ].
	
	df columnNames: col2 unique.
	^ df