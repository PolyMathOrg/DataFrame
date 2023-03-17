Class {
	#name : #DataFrameJsonReaderTest,
	#superclass : #TestCase,
	#instVars : [
		'directory',
		'df',
		'dfWithColNames',
		'dfWithRowNames',
		'dfWithRowColNames'
	],
	#category : #'DataFrame-IO-Tests-Core'
}

{ #category : #running }
DataFrameJsonReaderTest >> createFileNamed: name withContents: aString [
	| stream |
	stream := (directory / name) writeStream.
	stream nextPutAll: aString.
	stream close
]

{ #category : #running }
DataFrameJsonReaderTest >> setUp [
	super setUp.
	directory := FileSystem memory workingDirectory / 'testDataForJson'.
	directory createDirectory.

	self createFileNamed: 'column.json' withContents: TestJsonStrings columnJsonString.
	self createFileNamed: 'index.json' withContents: TestJsonStrings indexJsonString.
	self createFileNamed: 'nonNull1.json' withContents: TestJsonStrings nonNullJsonString1.
	self createFileNamed: 'records.json' withContents: TestJsonStrings recordsJsonString.
	self createFileNamed: 'split.json' withContents: TestJsonStrings splitJsonString.
	self createFileNamed: 'values.json' withContents: TestJsonStrings valuesJsonString.

	df := DataFrame withRows: #(
		(1 2 nil nil)
		(nil 2 3 nil)
		(nil nil nil 5)
		(1 nil 2 nil)).

	dfWithColNames := df deepCopy.
	dfWithColNames columnNames: #('col1' 'col2' 'col3' 'col4').

	dfWithRowNames := df deepCopy.
	dfWithRowNames rowNames: #('row1' 'row2' 'row3' 'row4').

	dfWithRowColNames := df deepCopy.
	dfWithRowColNames columnNames: #('col1' 'col2' 'col3' 'col4').
	dfWithRowColNames rowNames: #('row1' 'row2' 'row3' 'row4')
]

{ #category : #running }
DataFrameJsonReaderTest >> sortByRowColNames: inputDf [
	"Sorts df according to column and row names"

	| sortedRowNames sortedColNames dfColSorted outputDf |
	sortedRowNames := inputDf rowNames sorted.
	sortedColNames := inputDf columnNames sorted.

	dfColSorted := DataFrame withRowNames: inputDf rowNames.
	sortedColNames do: [ :col | dfColSorted addColumn: (inputDf column: col) asArray named: col ].

	outputDf := DataFrame withColumnNames: dfColSorted columnNames.
	sortedRowNames do: [ :row | outputDf addRow: (dfColSorted row: row) asArray named: row ].

	^ outputDf
]

{ #category : #tests }
DataFrameJsonReaderTest >> testReadFrom [
	| output |

	output := DataFrameJsonReader new readFrom: directory / 'nonNull1.json'.

	self assert: (self sortByRowColNames: output) equals: dfWithColNames
]

{ #category : #tests }
DataFrameJsonReaderTest >> testReadFromColumns [
	| output |

	output := DataFrameJsonReader new readFrom: directory / 'column.json'.

	self assert: (self sortByRowColNames: output) equals: dfWithRowColNames
]

{ #category : #tests }
DataFrameJsonReaderTest >> testReadFromIndex [
	| output |

	output := DataFrameJsonReader new readFrom: directory / 'index.json'.

	self assert: (self sortByRowColNames: output) equals: dfWithRowColNames transposed
]

{ #category : #tests }
DataFrameJsonReaderTest >> testReadFromJson [
	| output |
	output := DataFrame readFromJson: (directory / 'nonNull1.json').
	self assert: (self sortByRowColNames: output) equals: dfWithColNames
]

{ #category : #tests }
DataFrameJsonReaderTest >> testReadFromJsonOrient [
	| output |
	output := DataFrame readFromJson: (directory / 'split.json') orient: 'split'.
	self assert: (self sortByRowColNames: output) equals: dfWithRowColNames
]

{ #category : #tests }
DataFrameJsonReaderTest >> testReadFromRecords [
	| output |

	output := DataFrameJsonReader new readFrom: directory / 'records.json'.

	self assert: (self sortByRowColNames: output) equals: dfWithColNames
]

{ #category : #tests }
DataFrameJsonReaderTest >> testReadFromSplit [
	| output |

	output := DataFrameJsonReader new readFrom: directory / 'split.json'.

	self assert: (self sortByRowColNames: output) equals: dfWithRowColNames
]

{ #category : #tests }
DataFrameJsonReaderTest >> testReadFromString [
	| output |

	output := DataFrameJsonReader new readFrom: TestJsonStrings nonNullJsonString2.

	self assert: (self sortByRowColNames: output) equals: dfWithRowColNames
]

{ #category : #tests }
DataFrameJsonReaderTest >> testReadFromValues [
	| output |

	output := DataFrameJsonReader new readFrom: directory / 'values.json'.

	self assert: (self sortByRowColNames: output) equals: df
]
