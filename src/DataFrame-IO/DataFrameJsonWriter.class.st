Class {
	#name : #DataFrameJsonWriter,
	#superclass : #DataFrameWriter,
	#instVars : [
		'orient',
		'pretty',
		'writeMap'
	],
	#category : #'DataFrame-IO'
}

{ #category : #converting }
DataFrameJsonWriter class >> convertToColumns: aDataFrame [
	"Converts aDataFrame into following format:	
		{
		 column->{
					 rowName->data
					}
		}
		No need to actually convert, since dataframe gets iterated
		in the above format itself.
		Note: column is converted to string.
	"
	| output |
	
	output := Dictionary new.
	aDataFrame asArrayOfColumns withIndexDo: [ :col :index |
		output add: (aDataFrame columnNames at: index) asString -> col
		].
	^ output
]

{ #category : #converting }
DataFrameJsonWriter class >> convertToRecords: aDataFrame [
	"Converts aDataFrame into following format:
		[
			{column->data},
		]
		Note: It ignores rowNames
		No need to actually convert, since dataframe gets iterated
		in the above format itself.
	"
	
	^ aDataFrame
]

{ #category : #converting }
DataFrameJsonWriter class >> convertToRowNames: aDataFrame [
	"Converts aDataFrame into following format:	
		{
		 rowName->{
					 column->data
					}
		}
		No need to actually convert, since dataframe gets iterated
		in the above format itself.
		Note: rowName is converted to string.
	"
	| output |
	
	output := Dictionary new.
	aDataFrame asArrayOfRows withIndexDo: [ :row :index |
		output add: (aDataFrame rowNames at: index) asString -> row
		].
	^ output
]

{ #category : #converting }
DataFrameJsonWriter class >> convertToSplit: aDataFrame [
	"Converts aDataFrame into following format:
		{
			index->[rowNames],
			columns->[columnNames],
			data->[data]
		}
		Note: It ignores rowNames
		No need to actually convert, since dataframe gets iterated
		in the above format itself.
	"
	| output rows |
	
	output := Dictionary new.
	output add: 'index'->(aDataFrame rowNames).
	output add: 'columns'->(aDataFrame columnNames).
	
	rows := OrderedCollection new: aDataFrame size.
	aDataFrame do: [ :row | rows add: row asArray ].
	
	output add: 'data'->rows.
	^ output
]

{ #category : #converting }
DataFrameJsonWriter class >> convertToValues: aDataFrame [
	"Converts aDataFrame into an array of arrays
		Note: It ignores rowNames and columnNames
		No need to actually convert, since dataframe gets iterated
		in the above format itself.
	"
	| rows |
	
	rows := OrderedCollection new: aDataFrame size.
	aDataFrame do: [ :row | rows add: row asArray ].
	^ rows
]

{ #category : #accessing }
DataFrameJsonWriter >> defaultOrient [
	^ 'records'
]

{ #category : #accessing }
DataFrameJsonWriter >> defaultPretty [
	^ false
]

{ #category : #initialization }
DataFrameJsonWriter >> initialize [
	super initialize.
	orient := self defaultOrient.
	pretty := self defaultPretty.
	writeMap := Dictionary newFrom: {
		'records'->[ :aDataFrame :writeStream  | self class convertToRecords: aDataFrame].
		'split'->[ :aDataFrame :writeStream    | self class convertToSplit: aDataFrame].
		'columns'->[ :aDataFrame :writeStream  | self class convertToColumns: aDataFrame].
		'rowNames'->[ :aDataFrame :writeStream | self class convertToRowNames: aDataFrame].
		'values'->[ :aDataFrame :writeStream   | self class convertToValues: aDataFrame].
		}.
]

{ #category : #accessing }
DataFrameJsonWriter >> orient [
	^ orient
]

{ #category : #accessing }
DataFrameJsonWriter >> orient: aString [
	orient := aString
]

{ #category : #accessing }
DataFrameJsonWriter >> pretty [
	^ pretty
]

{ #category : #accessing }
DataFrameJsonWriter >> pretty: aBoolean [
	pretty := aBoolean
]

{ #category : #writing }
DataFrameJsonWriter >> write: aDataFrame to: aFileReference [
	| writeStream writer jsonObj |
	
	writeStream := aFileReference writeStream.
	writer := NeoJSONWriter new on: writeStream.
	writer prettyPrint: pretty.
	jsonObj := (writeMap at: orient) value: aDataFrame value: writeStream.
	writer nextPut: jsonObj.
	writer close.
]

{ #category : #writing }
DataFrameJsonWriter >> writeAsString: aDataFrame [
	"Returns JSON representation of aDataFrame according to orient"
	| writeStream writer jsonObj |
	
	writeStream := WriteStream on: (String new: 100).
	writer := NeoJSONWriter new on: writeStream.
	writer prettyPrint: pretty.
	jsonObj := (writeMap at: orient) value: aDataFrame value: writeStream.
	writer nextPut: jsonObj.
	writer close.
	^ writeStream contents
]
