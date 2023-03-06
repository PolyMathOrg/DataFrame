"
Implements a Text writer for DataFrame contents, including setting the alignment of each cell to the left and right.

# Example

```language=Pharo
(DataFrameCsvReader new
	readFromString: 'Given$a$text$file$of$many$lines,$where$fields$within$a$line$
are$delineated$by$a$single$''dollar''$character,$write$a$program
that$aligns$each$column$of$fields$by$ensuring$that$words$in$each$
column$are$separated$by$at$least$one$space.
Further,$allow$for$each$word$in$a$column$to$be$either$left$
justified,$right$justified,$or$center$justified$within$its$column.'
	withSeparator: $$
	withHeader: false)
		writeToTextAlignedRight
```
"
Class {
	#name : #DataFrameTextWriter,
	#superclass : #DataFrameCsvWriter,
	#instVars : [
		'padDirection'
	],
	#category : #'DataFrame-IO'
}

{ #category : #accessing }
DataFrameTextWriter >> padDirection [

	^ padDirection
]

{ #category : #accessing }
DataFrameTextWriter >> padDirection: anObject [

	padDirection := anObject
]

{ #category : #accessing }
DataFrameTextWriter >> padLeft [
	"Set the receiver to pad elements to left"

	self padDirection: #padLeftTo:
]

{ #category : #accessing }
DataFrameTextWriter >> padRight [
	"Set the receiver to pad elements to left"

	self padDirection: #padRightTo:
]

{ #category : #writing }
DataFrameTextWriter >> rowPairsFor: colWidths using: row [

	| gen |

	gen := Generator on: [ : g | colWidths do: [ : k | g yield: k ] ].
	^ row collect: [ : w | { w . gen next } ]
]

{ #category : #writing }
DataFrameTextWriter >> write: aDataFrame [
	"Answer a <String> representation of aDataFrame, aligned according to the receiver's padDirection"

	^ String streamContents: [ : stream |
		| colWidths |
		colWidths := aDataFrame applySize applyToAllColumns: #max.
		(aDataFrame collect: [ : row | self rowPairsFor: colWidths using: row ])
			do: [ : line |
				self writeLine: line to: stream.
				stream cr ] ]
]

{ #category : #writing }
DataFrameTextWriter >> writeLine: line to: stream [

	line do: [ : pair |
		pair first ifNotNil: [ : pf |
			stream
				<< (pf perform: self padDirection with: pair second);
				space ] ]
]
