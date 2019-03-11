Class {
	#name : #DataFrameCsvReaderTest,
	#superclass : #TestCase,
	#instVars : [
		'directory',
		'commaCsvFile',
		'tabCsvFile',
		'emptyCsvFile',
		'expectedDataFrame'
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
	directory := 'testData/' asFileReference.
	directory createDirectory.
	
	commaCsvFile := directory / 'comma.csv'.
	tabCsvFile :=  directory / 'tab.csv'.
	emptyCsvFile :=  directory / 'empty.csv'.
	
	self createFile: commaCsvFile withContents: TestCsvStrings commaCsvString.
	self createFile: tabCsvFile withContents: TestCsvStrings tabCsvString.
	self createFile: emptyCsvFile withContents: TestCsvStrings emptyCsvString.
	
	expectedDataFrame := DataFrame withRows: #(
		(2.4 true 'rain')
		(0.5 true 'rain')
		(-1.2 true 'snow')
		(-2.3 false '-')
		(3.2 true 'rain')).
		
	expectedDataFrame columnNames: #(temperature precipitation type).
	expectedDataFrame rowNames: (#('01:10' '01:30' '01:50' '02:10' '02:30')
		collect: #asTime).
]

{ #category : #running }
DataFrameCsvReaderTest >> tearDown [
	directory deleteAll.
]

{ #category : #tests }
DataFrameCsvReaderTest >> testReadCsv [
	| actualDataFrame |
	actualDataFrame := DataFrame readFromCsv: commaCsvFile.
	self assert: actualDataFrame equals: expectedDataFrame.
	
]

{ #category : #tests }
DataFrameCsvReaderTest >> testReadCsvWithSeparatorTab [
	| actualDataFrame |
	actualDataFrame := DataFrame readFromCsv: tabCsvFile withSeparator: Character tab.
	self assert: actualDataFrame equals: expectedDataFrame.
	
]
