Class {
	#name : #DataFrameCsvWriter,
	#superclass : #DataFrameWriter,
	#instVars : [
		'separator',
		'lineEndConvention'
	],
	#category : #'DataFrame-IO'
}

{ #category : #accessing }
DataFrameCsvWriter >> defaultLineEndConvention [
	^ {
		String cr -> #cr.
		String lf -> #lf.
		String crlf -> #crlf
	} asDictionary at: Smalltalk os lineEnding
]

{ #category : #accessing }
DataFrameCsvWriter >> defaultSeparator [
	^ $,
]

{ #category : #initialization }
DataFrameCsvWriter >> initialize [
	super initialize.
	separator := self defaultSeparator.
	lineEndConvention := self defaultLineEndConvention
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

{ #category : #accessing }
DataFrameCsvWriter >> separator [
	^ separator
]

{ #category : #accessing }
DataFrameCsvWriter >> separator: anObject [
	separator := anObject
]

{ #category : #writing }
DataFrameCsvWriter >> write: aDataFrame to: aFileReference [
	| stream writer |
	stream := aFileReference writeStream.

	writer := NeoCSVWriter on: stream.
	writer separator: self separator.
	writer lineEndConvention: self lineEndConvention.

	writer
		writeField: '';
		writeSeparator;
		writeHeader: aDataFrame columnNames.

	aDataFrame do: [ :row |
		writer
			writeField: row name;
			writeSeparator;
			nextPut: row ].

	writer close
]
