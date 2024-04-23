Class {
	#name : #DataFrameCsvWriter,
	#superclass : #DataFrameWriter,
	#instVars : [
		'separator',
		'lineEndConvention',
		'fieldWriter',
		'rowNameEnabled',
		'columnNameEnabled'
	],
	#category : #'DataFrame-IO-Core'
}

{ #category : #accessing }
DataFrameCsvWriter >> columnNameEnabled [

	^ columnNameEnabled
]

{ #category : #accessing }
DataFrameCsvWriter >> columnNameEnabled: aBoolean [

	columnNameEnabled := aBoolean = true
]

{ #category : #accessing }
DataFrameCsvWriter >> defaultColumnIndexEnabled [

	^ true
]

{ #category : #'accessing - field writers' }
DataFrameCsvWriter >> defaultFieldWriter [

	^ nil
]

{ #category : #accessing }
DataFrameCsvWriter >> defaultLineEndConvention [
	^ {
		String cr -> #cr.
		String lf -> #lf.
		String crlf -> #crlf
	} asDictionary at: Smalltalk os lineEnding
]

{ #category : #accessing }
DataFrameCsvWriter >> defaultRowIndexEnabled [

	^ true
]

{ #category : #accessing }
DataFrameCsvWriter >> defaultSeparator [
	^ $,
]

{ #category : #'enable/disable' }
DataFrameCsvWriter >> disableColumnName [

	self columnNameEnabled: false
]

{ #category : #'enable/disable' }
DataFrameCsvWriter >> disableRowName [

	self rowNameEnabled: false
]

{ #category : #'enable/disable' }
DataFrameCsvWriter >> enableColumnName [

	self columnNameEnabled: true
]

{ #category : #'enable/disable' }
DataFrameCsvWriter >> enableRowName [

	self rowNameEnabled: true
]

{ #category : #'accessing - field writers' }
DataFrameCsvWriter >> fieldWriter [

	^ fieldWriter
]

{ #category : #'accessing - field writers' }
DataFrameCsvWriter >> fieldWriter: aSymbol [

	fieldWriter := aSymbol
]

{ #category : #initialization }
DataFrameCsvWriter >> initialize [

	super initialize.
	separator := self defaultSeparator.
	lineEndConvention := self defaultLineEndConvention.
	fieldWriter := self defaultFieldWriter.
	rowNameEnabled := self defaultRowIndexEnabled.
	columnNameEnabled := self defaultColumnIndexEnabled
]

{ #category : #accessing }
DataFrameCsvWriter >> lineEndConvention [
	^ lineEndConvention
]

{ #category : #accessing }
DataFrameCsvWriter >> lineEndConvention: aSymbol [
	"Set the end of line convention to be used.
	Either #cr, #lf or #crlf (os convention by default)."

	self assert: (#(cr lf crlf) includes: aSymbol).
	lineEndConvention := aSymbol
]

{ #category : #'accessing - field writers' }
DataFrameCsvWriter >> objectFieldWriter [

	^ #object
]

{ #category : #'accessing - field writers' }
DataFrameCsvWriter >> optionalQuotedFieldWriter [

	^ #optionalQuoted
]

{ #category : #'accessing - field writers' }
DataFrameCsvWriter >> quotedFieldWriter [

	^ #quoted
]

{ #category : #'accessing - field writers' }
DataFrameCsvWriter >> rawFieldWriter [

	^ #raw
]

{ #category : #accessing }
DataFrameCsvWriter >> rowNameEnabled [

	^ rowNameEnabled
]

{ #category : #accessing }
DataFrameCsvWriter >> rowNameEnabled: aBoolean [

	rowNameEnabled := aBoolean = true
]

{ #category : #accessing }
DataFrameCsvWriter >> separator [
	^ separator
]

{ #category : #accessing }
DataFrameCsvWriter >> separator: anObject [
	separator := anObject
]

{ #category : #'accessing - field writers' }
DataFrameCsvWriter >> useObjectFieldWriter [

	self fieldWriter: self objectFieldWriter
]

{ #category : #'accessing - field writers' }
DataFrameCsvWriter >> useOptionalQuotedFieldWriter [

	self fieldWriter: self optionalQuotedFieldWriter
]

{ #category : #'accessing - field writers' }
DataFrameCsvWriter >> useQuotedFieldWriter [

	self fieldWriter: self quotedFieldWriter
]

{ #category : #'accessing - field writers' }
DataFrameCsvWriter >> useRawFieldWriter [

	self fieldWriter: self rawFieldWriter
]

{ #category : #writing }
DataFrameCsvWriter >> write: aDataFrame to: aFileReference [
	| stream writer |
	stream := aFileReference writeStream.
	writer := NeoCSVWriter on: stream.
	fieldWriter ifNotNil: [ writer fieldWriter: fieldWriter ].
	writer separator: self separator.
	writer lineEndConvention: self lineEndConvention.

	self columnNameEnabled ifTrue: [
		self rowNameEnabled ifTrue: [
		writer
			writeField: '';
			writeSeparator ].
	writer writeHeader: aDataFrame columnNames.

	self rowNameEnabled
		ifTrue: [
			aDataFrame do: [ :row |
				writer
					writeField: row name;
					writeSeparator;
					nextPut: row ] ]
		ifFalse: [ aDataFrame do: [ :row | writer nextPut: row ] ]]

	ifFalse: [
		self rowNameEnabled ifTrue: [
			aDataFrame do: [ :row |
				writer
					writeField: row name;
					writeSeparator;
					nextPut: row ] ]
		ifFalse: [ aDataFrame do: [ :row | writer nextPut: row ] ] ].

	writer close.

]
