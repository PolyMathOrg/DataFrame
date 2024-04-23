Class {
	#name : #DataFrameCsvWriterTest,
	#superclass : #TestCase,
	#instVars : [
		'directory',
		'dataFrame',
		'commaQuoteCsvFile',
		'tabQuoteCsvFile'
	],
	#category : #'DataFrame-IO-Tests-Core'
}

{ #category : #running }
DataFrameCsvWriterTest >> readFile: aFileReference [
	| stream contents |
	stream := aFileReference readStream.
	contents := stream upToEnd.
	stream close.
	^ contents
]

{ #category : #running }
DataFrameCsvWriterTest >> setUp [

	super setUp.
	directory := FileSystem memory workingDirectory / 'testData'.
	directory createDirectory.

	commaQuoteCsvFile := directory / 'commaQuote.csv'.
	tabQuoteCsvFile := directory / 'tabQuote.csv'.

	dataFrame := DataFrame withRows: #( #( 2.4 true 'rain' ) #( 0.5 true 'rain' ) #( -1.2 true 'snow' ) #( -2.3 false '-' ) #( 3.2 true 'rain' ) ).

	dataFrame columnNames: #( temperature precipitation type ).
	dataFrame rowNames: (#( '01:10' '01:30' '01:50' '02:10' '02:30' ) collect: #asTime)
]

{ #category : #tests }
DataFrameCsvWriterTest >> testWriteToCsv [
	| actual expected |
	dataFrame writeToCsv: commaQuoteCsvFile.
	actual := self readFile: commaQuoteCsvFile.
	expected := TestCsvStrings commaQuoteCsvString.
	self assert: actual lines equals: expected lines
]

{ #category : #tests }
DataFrameCsvWriterTest >> testWriteToCsvLineEndLf [
	| writer actual expected |
	writer := DataFrameCsvWriter new.
	writer lineEndConvention: #lf.
	dataFrame writeTo: commaQuoteCsvFile using: writer.
	actual := self readFile: commaQuoteCsvFile.
	expected := String lf join: TestCsvStrings commaQuoteCsvString lines.
	self assert: actual lines equals: expected lines
]

{ #category : #tests }
DataFrameCsvWriterTest >> testWriteToCsvWithRawFieldWriter [

	| file writer actual expected |
	file := FileSystem memory workingDirectory / 'testData' / 'raw.csv'.
	file ensureCreateFile.
	writer := DataFrameCsvWriter new.
	writer useRawFieldWriter.
	dataFrame writeTo: file using: writer.
	actual := self readFile: file.
	expected := TestCsvStrings commaCsvString.
	self assert: actual lines equals: expected lines
]

{ #category : #tests }
DataFrameCsvWriterTest >> testWriteToCsvWithRawFieldWriterWithoutRowName [

	| file writer actual expected |
	file := FileSystem memory workingDirectory / 'testData' / 'raw.csv'.
	file ensureCreateFile.
	writer := DataFrameCsvWriter new.
	writer
		useRawFieldWriter;
		disableRowName.
	dataFrame writeTo: file using: writer.
	actual := self readFile: file.
	expected := TestCsvStrings commaCsvWithoutRowNameString.
	self assert: actual lines equals: expected lines
]

{ #category : #tests }
DataFrameCsvWriterTest >> testWriteToCsvWithSeparatorTab [
	| actual expected |
	dataFrame writeToCsv: tabQuoteCsvFile withSeparator: Character tab.
	actual := self readFile: tabQuoteCsvFile.
	expected := TestCsvStrings tabQuoteCsvString.
	self assertCollection: actual lines equals: expected lines
]

{ #category : #tests }
DataFrameCsvWriterTest >> testWriteToCsvWithoutColumnNames [
	| actual expected |
	dataFrame writeToCsv: commaQuoteCsvFile withColumnNames: false.
	actual := self readFile: commaQuoteCsvFile.
	expected := TestCsvStrings commaQuoteCsvStringWithoutColumnNames.
	self assert: actual lines equals: expected lines
]

{ #category : #tests }
DataFrameCsvWriterTest >> testWriteToCsvWithoutRowNames [
	| actual expected |
	dataFrame writeToCsv: commaQuoteCsvFile withRowNames: false.
	actual := self readFile: commaQuoteCsvFile.
	expected := TestCsvStrings commaQuoteCsvStringWithoutRowNames.
	self assert: actual lines equals: expected lines
]

{ #category : #tests }
DataFrameCsvWriterTest >> testWriteToCsvWithoutRowNamesWithoutColumnNames [
	| actual expected |
	dataFrame writeToCsv: commaQuoteCsvFile withColumnNames: false withRowNames: false.
	actual := self readFile: commaQuoteCsvFile.
	expected := TestCsvStrings commaQuoteCsvStringWithoutRowNamesWithoutColumnNames.
	self assert: actual lines equals: expected lines
]
