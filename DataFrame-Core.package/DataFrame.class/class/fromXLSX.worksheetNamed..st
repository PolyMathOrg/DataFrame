instance creation
fromXLSX: pathToFile worksheetNamed: sheetName

	| file workbook sheet |
	
	file := FileStream readOnlyFileNamed: pathToFile.
	workbook := XLSXImporter import file.
	sheet := workbook worksheetNamed: sheetName.
	
	^ self fromXLSXworksheet: sheet.