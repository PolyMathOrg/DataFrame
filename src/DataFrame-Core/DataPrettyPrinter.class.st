Class {
	#name : #DataPrettyPrinter,
	#superclass : #Object,
	#instVars : [
		'columnLengths',
		'columnAligns',
		'separator'
	],
	#category : 'DataFrame-Core-PrettyPrint'
}

{ #category : #'as yet unclassified' }
DataPrettyPrinter >> eachColumnAlign: aDataFrame [
"Returns an array of characters specifying how each column should be aligned based on its type. Possible values are #LEFT, #RIGHT, and #CENTER"

	^ aDataFrame columnTypes collect: [ :type |
		((type inheritsFrom: String) or:
		(type == String))
			ifTrue: [ #LEFT ]
			ifFalse: [ #RIGHT ] ].
]

{ #category : #'as yet unclassified' }
DataPrettyPrinter >> eachColumnMaxLength: aDataFrame [
"For every column converts all values to strind and determines the length of the longest string"

	| maxLenArray findMaxLen |
	
	maxLenArray := Array new: (aDataFrame numberOfColumns + 1).
	
	findMaxLen := [ :initMaxLen :column |
		| len maxLen |
		maxLen := initMaxLen.
		
		(1 to: column size) do: [ :i |
			len := (column at: i) asString size.
			
			len > maxLen
				ifTrue: [ maxLen := len ] ].
		maxLen ].
	
	maxLenArray at: 1 put:
		(findMaxLen value: 0 value: aDataFrame rowNames).
	
	1 to: aDataFrame numberOfColumns do: [ :i |
		| column |
		column := aDataFrame columnAt: i.
		
		maxLenArray at: (i + 1) put:
			(findMaxLen
				value: column name asString size
				value: column) ].
			
	^ maxLenArray
]

{ #category : #'as yet unclassified' }
DataPrettyPrinter >> offsetWithSpaces: aNumber [
"Generates a string filled with a given number of spaces"
	
	^ (1 to: aNumber) inject: '' into: [ :offset :i |
		offset, ' ' ].
]

{ #category : #printing }
DataPrettyPrinter >> print: aDataFrame on: aStream [
"Pretty-prints a data frame"
	
	columnLengths := self eachColumnMaxLength: aDataFrame.
	columnAligns := self eachColumnAlign: aDataFrame.
	separator := '  '.
	
	self printRow: (aDataFrame columnNames) andKey: '' on: aStream.
	aStream cr.
	
	self printLineOn: aStream.
	aStream cr.
	
	1 to: aDataFrame numberOfRows do: [ :i |
		self printRow: i of: aDataFrame on: aStream.
		aStream cr ].
]

{ #category : #printing }
DataPrettyPrinter >> printLineOn: aStream [

	| numberOfColumns sumColLen sumOffset keySideLen valSideLen |
	
	numberOfColumns := columnLengths size.
	sumColLen := columnLengths sum - (columnLengths at: 1).
	sumOffset := (separator size) * numberOfColumns.
	
	keySideLen := (columnLengths at: 1) + (separator size).
	valSideLen := sumColLen + sumOffset.
	
	1 to: keySideLen do: [ :i |
		aStream nextPutAll: '-' ].
	
	aStream nextPutAll: '+'.
	
	1 to: valSideLen do: [ :i |
		aStream nextPutAll: '-' ].
]

{ #category : #printing }
DataPrettyPrinter >> printRow: aRow andKey: aKey on: aStream [

	| cellStr offset |
	
	cellStr := aKey asString.
	
	offset := self offsetWithSpaces:
			((columnLengths at: 1) - cellStr size).
			
	(columnAligns at: 1) = #RIGHT
			ifTrue: [ cellStr := offset, cellStr ].
		(columnAligns at: 1) = #LEFT
			ifTrue: [ cellStr := cellStr, offset ].
			
	aStream
			nextPutAll: cellStr;
			nextPutAll: separator;
			nextPutAll: '|';
			nextPutAll: separator.

	1 to: aRow size do: [ :i |
		cellStr := (aRow at: i) asString.
		offset := self offsetWithSpaces:
			((columnLengths at: i + 1) - cellStr size).
			
		(columnAligns at: i) = #RIGHT
			ifTrue: [ cellStr := offset, cellStr ].
		(columnAligns at: i) = #LEFT
			ifTrue: [ cellStr := cellStr, offset ].
				
		aStream
			nextPutAll: cellStr;
			nextPutAll: separator. ].
]

{ #category : #printing }
DataPrettyPrinter >> printRow: aNumber of: aDataFrame on: aStream [

	| row key |
	row := aDataFrame rowAt: aNumber.
	key := (aDataFrame rowNames at: aNumber) asString.
	self printRow: row andKey: key on: aStream.
]
