queries
select: colNames groupBy: aColName aggregate: selector
	
	| df |
	
	df := (colNames includes: aColName)
		ifTrue: [ self columns: colNames ]
		ifFalse: [ self columns: (colNames copyWith: aColName) ].
	
	^ df groupBy: aColName aggregate: selector.