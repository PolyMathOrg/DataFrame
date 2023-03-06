Class {
	#name : #DataFrameJsonWriterTest,
	#superclass : #TestCase,
	#instVars : [
		'directory',
		'df'
	],
	#category : #'DataFrame-IO-Tests'
}

{ #category : #running }
DataFrameJsonWriterTest >> readFile: aFileReference [
	| stream contents |
	stream := aFileReference readStream.
	contents := stream upToEnd.
	stream close.
	^ contents
]

{ #category : #running }
DataFrameJsonWriterTest >> setUp [
	super setUp.
	directory := FileSystem memory workingDirectory / 'testDataForJson'.
	directory createDirectory.

	df := DataFrame withRows: #(
		(1 2 nil nil)
		(nil 2 3 nil)
		(nil nil nil 5)
		(1 nil 2 nil))
	rowNames: #('row1' 'row2' 'row3' 'row4')
	columnNames: #('col1' 'col2' 'col3' 'col4')
]

{ #category : #tests }
DataFrameJsonWriterTest >> testWriteAsString [
	| actual expected |.
	actual := DataFrameJsonWriter new writeAsString: df.
	expected := '' join: (TestJsonStrings recordsJsonString
		regex: '[^\s]+' matchesCollect: [:x|x]).
	self assert: actual equals: expected
]

{ #category : #tests }
DataFrameJsonWriterTest >> testWriteTo [
	| file actual expected |
	file := directory / 'output.json'.
	DataFrameJsonWriter new write: df to: file.
	actual := self readFile: file.
	expected := '' join: (TestJsonStrings recordsJsonString
		regex: '[^\s]+' matchesCollect: [:x|x]).
	self assert: actual lines equals: expected lines
]

{ #category : #tests }
DataFrameJsonWriterTest >> testWriteToJson [
	| file actual expected |
	file := directory / 'output.json'.
	df writeToJson: file.
	actual := self readFile: file.
	expected := '' join: (TestJsonStrings recordsJsonString
		regex: '[^\s]+' matchesCollect: [:x|x]).
	self assert: actual lines equals: expected lines
]

{ #category : #tests }
DataFrameJsonWriterTest >> testWriteToJsonOrient [
	| file actual expected |
	file := directory / 'output.json'.
	df writeToJson: file orient: 'values'.
	actual := self readFile: file.
	expected := '' join: (TestJsonStrings valuesJsonString
		regex: '[^\s]+' matchesCollect: [:x|x]).
	self assert: actual lines equals: expected lines
]
