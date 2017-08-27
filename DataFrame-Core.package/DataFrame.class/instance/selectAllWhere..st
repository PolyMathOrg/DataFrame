as yet unclassified
selectAllWhere: aBlock

	| testedColumnNames |
	testedColumnNames := aBlock argumentNames.
	
	(self columnNames includesAll: testedColumnNames)
		ifFalse: [ Error signal: 'All arguments of the where block must correspond to the column names of a data frame' ].
		
	^ self select: aBlock with: testedColumnNames