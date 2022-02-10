"
I read csv files and convert them into DataFrames.

I read text files containing multiple columns separated by a `separator` character. The first row will become the column names of the DataFrame. As I read the file I detect the type of data in the columns. I currently know how to detect and convert floating point numbers, integers, dates, and times. When I can't detect a consistent type for all rows of a column I leave the column type as a string.

My behaviour can be modified by changing the column separator with `sepatator:`, turning off column type conversion using `shouldInferTypes: false`, or setting the first column as the row names using `includeRowNames: true`.

Use the `readFrom:` message to read a stream and return a `DataFrame`:

    reader := DataFrameCsvReader new.
    reader readFrom: (FileLocator home / 'data.csv') 

Modify my behaviour before calling `readFrom:`. The following example reads from a tab-separated stream and turns off any type conversions so all columns will be strings:

    df := DataFrameCsvReader new separator: Character tab; 
            shouldInferTypes: false;
            readFrom: aStream

It is also possible to specify the types of the columns in the file by passing a dictionary to `columnTypes:` message. Column type conversion only happens if `shouldInferTypes` is true. Refer to `DataFrameTypeDetector` for more information about the format of the dictionary to be given to `columnTypes:`.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	includeRowNames:		Boolean
	separator:		Character
	shouldInferTypes:		Boolean


    Implementation Points
"
Class {
	#name : #DataFrameCsvReader,
	#superclass : #DataFrameReader,
	#instVars : [
		'separator',
		'includeRowNames',
		'shouldInferTypes',
		'rowNames',
		'rows',
		'columnNames'
	],
	#category : #'DataFrame-IO'
}

{ #category : #reading }
DataFrameCsvReader >> createDataFrame [
	| df |
	df := DataFrame
		withRows: rows
		columnNames: columnNames.
		
	self includeRowNames ifTrue: [ 
		df rowNames: rowNames ].
	
	^ df
]

{ #category : #accessing }
DataFrameCsvReader >> defaultIncludeRowNames [
	^ false
]

{ #category : #accessing }
DataFrameCsvReader >> defaultSeparator [
	^ $,
]

{ #category : #accessing }
DataFrameCsvReader >> defaultShouldInferTypes [
	^ true
]

{ #category : #accessing }
DataFrameCsvReader >> includeRowNames [
	^ includeRowNames
]

{ #category : #accessing }
DataFrameCsvReader >> includeRowNames: anObject [
	includeRowNames := anObject
]

{ #category : #initialization }
DataFrameCsvReader >> initialize [
	super initialize.
	separator := self defaultSeparator.
	includeRowNames := self defaultIncludeRowNames.
	shouldInferTypes := self defaultShouldInferTypes.
	columnTypes := Dictionary new.
]

{ #category : #reading }
DataFrameCsvReader >> readColumnNamesWith: aReader [
	columnNames := aReader readHeader.
	
	self includeRowNames ifTrue: [
		columnNames := columnNames copyWithoutFirst ].
]

{ #category : #reading }
DataFrameCsvReader >> readFrom: aFileReference [
	"Read data frame from a CSV file"
	| df | 
	df := self readFromInternal: aFileReference .
	shouldInferTypes ifTrue: [
		DataFrameTypeDetector new columnTypes: columnTypes; detectTypesAndConvert: df ].
	^ df
	
]

{ #category : #reading }
DataFrameCsvReader >> readFromInternal: aFileReference [
	"Read data frame from a CSV file"

	| stream reader df |
	stream := aFileReference readStream.
	reader := NeoCSVReader on: stream.
	reader separator: self separator.

	self readColumnNamesWith: reader.
	self readRowsWith: reader.
	reader close.
	df := self createDataFrame.
	^ df
]

{ #category : #reading }
DataFrameCsvReader >> readOnlyRowsWith: aReader [
	rows := OrderedCollection new.
	
	[ aReader atEnd ] whileFalse: [ 
		rows add: aReader next ].
]

{ #category : #reading }
DataFrameCsvReader >> readRowsAndRowNamesWith: aReader [
	| line |
	rowNames := OrderedCollection new.
	rows := OrderedCollection new.
	
	[ aReader atEnd ] whileFalse: [ 
		line := aReader next.
		rowNames add: line first.
		rows add: line copyWithoutFirst ].
]

{ #category : #reading }
DataFrameCsvReader >> readRowsWith: aReader [
	^ self includeRowNames
		ifTrue: [ self readRowsAndRowNamesWith: aReader ]
		ifFalse: [ self readOnlyRowsWith: aReader ].
]

{ #category : #accessing }
DataFrameCsvReader >> separator [
	^ separator
]

{ #category : #accessing }
DataFrameCsvReader >> separator: anObject [
	separator := anObject
]

{ #category : #accessing }
DataFrameCsvReader >> shouldInferTypes [
	^ shouldInferTypes
]

{ #category : #accessing }
DataFrameCsvReader >> shouldInferTypes: anObject [
	shouldInferTypes := anObject
]
