instance creation
fromXLSX: pathToFile

	| file workbook sheet |
	
	file := FileStream readOnlyFileNamed: pathToFile.
	workbook := XLSXImporter import: file.
	sheet := workbook worksheets first.
	
	^ self fromXLSXworksheet: sheet.