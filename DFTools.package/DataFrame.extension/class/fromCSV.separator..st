*DFTools-NeoCSV
fromCSV: pathToFile separator: separator

	^ self
		fromCSV: pathToFile
		separator: separator
		header: false