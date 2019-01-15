queries
select: colNames where: aBlock groupBy: aColName aggregate: selector
	
	^ (self select: colNames where: aBlock)
		groupBy: aColName
		aggregate: selector.