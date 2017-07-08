instance creation
fromContents: aDataFrameIndernal rowNames: rows columnNames: columns

	^ self new
		initializeContents: aDataFrameIndernal
		rowNames: rows
		columnNames: columns.