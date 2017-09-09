accessing
quantitativeColumns

	^ self columnNames select: [ :colName |
		(self column: colName) isQuantitative ]