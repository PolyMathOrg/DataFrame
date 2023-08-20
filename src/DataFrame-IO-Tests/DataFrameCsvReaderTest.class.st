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
	#category : #'DataFrame-IO-Tests-Core'
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
DataFrameCsvReaderTest >> testReadCsvWithColumnNamesWithSeparator [

	| controlDataFrame customColumnNames |
	
	customColumnNames := #('Col1' 'Col2' 'Col3' 'Col4').

	controlDataFrame := DataFrame 
		readFromCsv: tabCsvFile 
		withColumnNames: customColumnNames
		separator: Character tab.

	self 
		assertCollection: controlDataFrame columnNames 
		equals: customColumnNames asOrderedCollection.
		
	"The original header is counted as a normal row now"
	self 
		assert: controlDataFrame size 
		equals: 6.
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
DataFrameCsvReaderTest >> testReadCsvWithSeparatorTabSkip1 [

	| doubleHeaderString controlDataFrame dataFrameWithoutFirstLine |

	doubleHeaderString := 'a description header
' , TestCsvStrings tabCsvString.
	dataFrameWithoutFirstLine := DataFrame readFromCsv: doubleHeaderString withSeparator: Character tab skip: 1.

	controlDataFrame := DataFrame 
		withRows: #( 
			#('1:10 am' '2.4' 'true' 'rain')
			#('1:30 am' '0.5' 'true' 'rain') 
			#('1:50 am' '-1.2' 'true' 'snow') 
			#('2:10 am' '-2.3' 'false' '-') 
			#('2:30 am' '3.2' 'true' 'rain' ))
		columnNames: #(nil temperature precipitation type ).

	self assert: controlDataFrame equals: dataFrameWithoutFirstLine
]

{ #category : #tests }
DataFrameCsvReaderTest >> testReadCsvWithSeparatorTabSkipN [

	| doubleHeaderString controlDataFrame dataFrameWithoutTwoFirstLines |

	doubleHeaderString := 'a description header
another description header
' , TestCsvStrings tabCsvString.
	dataFrameWithoutTwoFirstLines := DataFrame readFromCsv: doubleHeaderString withSeparator: Character tab skip: 2.

	controlDataFrame := DataFrame 
		withRows: #( 
			#('1:10 am' '2.4' 'true' 'rain')
			#('1:30 am' '0.5' 'true' 'rain') 
			#('1:50 am' '-1.2' 'true' 'snow') 
			#('2:10 am' '-2.3' 'false' '-') 
			#('2:30 am' '3.2' 'true' 'rain' ))
		columnNames: #(nil temperature precipitation type ).

	self assert: controlDataFrame equals: dataFrameWithoutTwoFirstLines
]

{ #category : #tests }
DataFrameCsvReaderTest >> testReadFromString [

	| actualDataFrame |
	actualDataFrame := DataFrameCsvReader new readFromString: TestCsvStrings commaCsvString.

	self
		assertCollection: actualDataFrame asArrayOfColumns first
		hasSameElements: #('1:10 am' '1:30 am' '1:50 am' '2:10 am' '2:30 am').
	self
		assertCollection: actualDataFrame asArrayOfColumns last
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
