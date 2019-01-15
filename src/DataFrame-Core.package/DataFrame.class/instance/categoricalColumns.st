accessing
categoricalColumns

	^ self columnNames select: [ :colName |
		(self column: colName) isCategorical ]