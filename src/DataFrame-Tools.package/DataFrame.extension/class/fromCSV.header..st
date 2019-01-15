*DataFrame-Tools-NeoCSV
fromCSV: pathToFile header: containsHeader

	^ self
		fromCSV: pathToFile
		separator: $,
		header: containsHeader.