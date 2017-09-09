removing
removeColumnAt: columnNumber

	contents removeColumnAt: columnNumber.
	columnNames := columnNames copyWithoutIndex: columnNumber.
	columnTypes := columnTypes copyWithoutIndex: columnNumber.