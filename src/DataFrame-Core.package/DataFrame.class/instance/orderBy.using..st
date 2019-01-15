sorting
orderBy: columnName using: aBlock

	| column sortedKeys newContents |
	column := self column: columnName.
	column sort: aBlock.
	sortedKeys := column keys.
	
	newContents := DataFrameInternal new: self dimensions.
	
	1 to: self numberOfRows do: [ :i |
		newContents rowAt: i put:
			(self row: (sortedKeys at: i)) ].
		
	contents := newContents.
	self rowNames: sortedKeys.