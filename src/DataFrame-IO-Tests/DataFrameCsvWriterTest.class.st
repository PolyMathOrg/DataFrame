Class {
	#name : #DataFrameCsvWriterTest,
	#superclass : #TestCase,
	#instVars : [
		'directory',
		'dataFrame',
		'commaQuoteCsvFile',
		'tabQuoteCsvFile'
	],
	#category : #'DataFrame-IO-Tests'
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
DataFrameCsvWriterTest >> testWriteToCsvWithSeparatorTab [
	| actual expected |
	dataFrame writeToCsv: tabQuoteCsvFile withSeparator: Character tab.
	actual := self readFile: tabQuoteCsvFile.
	expected := TestCsvStrings tabQuoteCsvString.
	self assertCollection: actual lines equals: expected lines
]
