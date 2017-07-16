as yet unclassified
group: colNameOrArray by: colName

	| left right |
	
	left := colNameOrArray isArray
		ifTrue: [ self columns: colNameOrArray ]	"a DataFrame"
		ifFalse: [ self column: colNameOrArray ].	"a DataSeries"
		
	right := self column: colName.
	
	^ left groupBy: right.