queries
select: colNames where: aBlock
	
	^ (self selectAllWhere: aBlock) columns: colNames