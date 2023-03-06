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
	stream close
]

{ #category : #running }
DataFrameCsvReaderTest >> setUp [

	super setUp.
	directory := FileSystem memory workingDirectory / 'testData'.
	directory createDirectory.

	commaCsvFile := directory / 'comma.csv'.
	tabCsvFile := directory / 'tab.csv'.
	emptyCsvFile := directory / 'empty.csv'.

	self createFile: commaCsvFile withContents: TestCsvStrings commaCsvString.
	self createFile: tabCsvFile withContents: TestCsvStrings tabCsvString.
	self createFile: emptyCsvFile withContents: TestCsvStrings emptyCsvString.

	dataFrameWithRowNames := DataFrame withRows: #( #( 2.4 true 'rain' ) #( 0.5 true 'rain' ) #( -1.2 true 'snow' ) #( -2.3 false '-' ) #( 3.2 true 'rain' ) ).

	dataFrameWithRowNames columnNames: #( temperature precipitation type ).
	dataFrameWithRowNames rowNames: (#( '01:10' '01:30' '01:50' '02:10' '02:30' ) collect: #asTime).

	dataFrameWithoutRowNames := DataFrame withRows: {
			                            {
				                            '01:10' asTime.
				                            2.4.
				                            true.
				                            'rain' }.
			                            {
				                            '01:30' asTime.
				                            0.5.
				                            true.
				                            'rain' }.
			                            {
				                            '01:50' asTime.
				                            -1.2.
				                            true.
				                            'snow' }.
			                            {
				                            '02:10' asTime.
				                            -2.3.
				                            false.
				                            '-' }.
			                            {
				                            '02:30' asTime.
				                            3.2.
				                            true.
				                            'rain' } }.

	dataFrameWithoutRowNames columnNames: #( nil temperature precipitation type )
]

{ #category : #tests }
DataFrameCsvReaderTest >> testReadCsv [
	| actualDataFrame |
	actualDataFrame := DataFrame readFromCsv: commaCsvFile.
	self assert: actualDataFrame equals: dataFrameWithoutRowNames
]

{ #category : #tests }
DataFrameCsvReaderTest >> testReadCsvWithRowNames [
	| actualDataFrame |
	actualDataFrame := DataFrame readFromCsvWithRowNames: commaCsvFile.
	self assert: actualDataFrame equals: dataFrameWithRowNames
]

{ #category : #tests }
DataFrameCsvReaderTest >> testReadCsvWithRowNamesWithSeparatorTab [
	| actualDataFrame |
	actualDataFrame := DataFrame readFromCsvWithRowNames: tabCsvFile separator: Character tab.
	self assert: actualDataFrame equals: dataFrameWithRowNames
]

{ #category : #tests }
DataFrameCsvReaderTest >> testReadCsvWithSeparatorTab [
	| actualDataFrame |
	actualDataFrame := DataFrame readFromCsv: tabCsvFile withSeparator: Character tab.
	self assert: actualDataFrame equals: dataFrameWithoutRowNames
]

{ #category : #tests }
DataFrameCsvReaderTest >> testReadFromString [

	| actualDataFrame |
	actualDataFrame := DataFrameCsvReader new readFromString: TestCsvStrings commaCsvString.

	self
		assertCollection: actualDataFrame columns first
		hasSameElements: #('1:10 am' '1:30 am' '1:50 am' '2:10 am' '2:30 am').
	self
		assertCollection: actualDataFrame columns last
		hasSameElements: #('rain' 'rain' 'snow' '-' 'rain')
]

{ #category : #tests }
DataFrameCsvReaderTest >> testReadFromStringWithSeparatorWithHeader [

	| df |
	df := DataFrameCsvReader new
		readFromString: TestCsvStrings dollarSignCsvString
		withSeparator: $$
		withHeader: false.

	self assert: df dimensions equals: 6 @ 13.
	self assertCollection: df columnNames hasSameElements: (1 to: 13) asArray.
	self
		assertCollection: df first values
		hasSameElements: #('Given' 'a' 'text' 'file' 'of' 'many' 'lines,' 'where' 'fields' 'within' 'a' 'line' nil)
]
