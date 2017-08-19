as yet unclassified
on: columns select: aBlock with: columnArgs groupedBy: colsToGroup

	^ (self on: columns
		select: aBlock
		with: columnArgs)
		groupBy: colsToGroup.