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
		DataFrameTypeDetector new detectTypesAndConvert: df ].
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
