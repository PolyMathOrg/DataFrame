Class {
	#name : #DataFrameCsvReaderTest,
	#superclass : #TestCase,
	#instVars : [
		'directory',
		'commaCsvFile',
		'tabCsvFile',
		'emptyCsvFile',
		'expectedDataFrame',
		'dataFrameWithoutRowNames',
		'dataFrameWithRowNames'
	],
	#category : #'DataFrame-IO-Tests'
}

{ #category : #running }
DataFrameCsvReaderTest >> createFile: aFileReference withContents: aString [
	| stream |
	stream := aFileReference writeStream.
	stream nextPutAll: aString.
	stream close.
]

{ #category : #running }
DataFrameCsvReaderTest >> setUp [
	directory := FileSystem memory workingDirectory / 'testData'.
	directory createDirectory.
	
	commaCsvFile := directory / 'comma.csv'.
	tabCsvFile :=  directory / 'tab.csv'.
	emptyCsvFile :=  directory / 'empty.csv'.
	
	self createFile: commaCsvFile withContents: TestCsvStrings commaCsvString.
	self createFile: tabCsvFile withContents: TestCsvStrings tabCsvString.
	self createFile: emptyCsvFile withContents: TestCsvStrings emptyCsvString.
	
	dataFrameWithRowNames := DataFrame withRows: #(
		(2.4 true 'rain')
		(0.5 true 'rain')
		(-1.2 true 'snow')
		(-2.3 false '-')
		(3.2 true 'rain')).
		
	dataFrameWithRowNames columnNames: #(temperature precipitation type).
	dataFrameWithRowNames rowNames: (#('01:10' '01:30' '01:50' '02:10' '02:30')
		collect: #asTime).
		
	dataFrameWithoutRowNames := DataFrame withRows: {
		{ '01:10' asTime . 2.4 . true . 'rain' } .
		{ '01:30' asTime . 0.5 . true . 'rain' } .
		{ '01:50' asTime . -1.2 . true . 'snow' } .
		{ '02:10' asTime . -2.3 . false . '-' } . 
		{ '02:30' asTime . 3.2 . true . 'rain' }}.
		
	dataFrameWithoutRowNames columnNames: #(nil temperature precipitation type).
]

{ #category : #tests }
DataFrameCsvReaderTest >> testReadCsv [
	| actualDataFrame |
	actualDataFrame := DataFrame readFromCsv: commaCsvFile.
	self assert: actualDataFrame equals: dataFrameWithoutRowNames.
	
]

{ #category : #tests }
DataFrameCsvReaderTest >> testReadCsvWithRowNames [
	| actualDataFrame |
	actualDataFrame := DataFrame readFromCsvWithRowNames: commaCsvFile.
	self assert: actualDataFrame equals: dataFrameWithRowNames.
	
]

{ #category : #tests }
DataFrameCsvReaderTest >> testReadCsvWithRowNamesWithSeparatorTab [
	| actualDataFrame |
	actualDataFrame := DataFrame readFromCsvWithRowNames: tabCsvFile separator: Character tab.
	self assert: actualDataFrame equals: dataFrameWithRowNames.
	
]

{ #category : #tests }
DataFrameCsvReaderTest >> testReadCsvWithSeparatorTab [
	| actualDataFrame |
	actualDataFrame := DataFrame readFromCsv: tabCsvFile withSeparator: Character tab.
	self assert: actualDataFrame equals: dataFrameWithoutRowNames.
	
]
