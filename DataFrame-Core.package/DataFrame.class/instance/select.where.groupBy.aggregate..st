as yet unclassified
select: colNames where: aBlock groupBy: aColName aggregate: selector
	
	^ ((self select: colNames where: aBlock)
		groupBy: aColName) perform: selector.