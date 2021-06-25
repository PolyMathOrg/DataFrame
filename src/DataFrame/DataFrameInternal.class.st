"
I am  the internal representation of a DataFrame. I store the data very efficiently and allow you to access it very quickly. 
"
Class {
	#name : #DataFrameInternal,
	#superclass : #Collection,
	#instVars : [
		'contents'
	],
	#category : #'DataFrame-Core'
}

{ #category : #'instance creation' }
DataFrameInternal class >> fromArray2D: anArray2D [

	| dfInternal |
	
	"We can't use Array2D>>extent, because it gives us col@row instead of row@col"
	dfInternal := self new:
		(anArray2D rowCount @ anArray2D columnCount).
	
	anArray2D withIndicesDo: [ :each :i :j |
		dfInternal at: i at: j put: each ].
	
	^ dfInternal
]

{ #category : #'instance creation' }
DataFrameInternal class >> new: aPoint [

	^ self new initialize: aPoint
]

{ #category : #'instance creation' }
DataFrameInternal class >> withColumns: anArrayOfArrays [
	
	| numberOfRows numberOfColumns dfInternal |
	
	numberOfColumns := anArrayOfArrays size.
	numberOfRows := 0.
	1 to: numberOfColumns do: [ :index |
		numberOfRows := numberOfRows max: (anArrayOfArrays at: index) size
		].
	dfInternal := self new: (numberOfRows @ numberOfColumns ).
	
	1 to: numberOfRows do: [ :i |
		1 to: numberOfColumns do: [ :j |
			dfInternal at: i at: j
				put: ((anArrayOfArrays at: j) asArray at: i ifAbsent: nil) ] ].
		
	^ dfInternal
]

{ #category : #'instance creation' }
DataFrameInternal class >> withRows: anArrayOfArrays [

	| numberOfRows numberOfColumns dfInternal |
	
	numberOfRows := anArrayOfArrays size.
	numberOfColumns := 0.
	1 to: numberOfRows do: [ :index |
		numberOfColumns := numberOfColumns max: (anArrayOfArrays at: index) size
		].
	dfInternal := self new: numberOfRows @ numberOfColumns.
	
	1 to: numberOfRows do: [ :i | 
		1 to: numberOfColumns do: [ :j | 
			dfInternal at: i at: j
				put: ((anArrayOfArrays at: i) asArray at: j ifAbsent: nil) ] ].
	
	^ dfInternal
]

{ #category : #comparing }
DataFrameInternal >> = other [

	((other class == self class)
		and: [ other numberOfRows = self numberOfRows 
		and: [ other numberOfColumns = self numberOfColumns]])
		ifFalse: [ ^ false ].
		
	other withIndicesDo: [ :each :i :j |
		(self at: i at: j) = each
			ifFalse: [ ^ false ] ].
		
	^ true.

	
	
]

{ #category : #adding }
DataFrameInternal >> addColumn: anArray atPosition: aNumber [

	| rows cols newContents |
	
	rows := self numberOfRows.
	cols := self numberOfColumns + 1.
	
	anArray size = rows
		ifFalse: [ SizeMismatch signal ].
	
	newContents := Array2D
		rows: rows
		columns: cols.
	
	1 to: rows do: [ :i |
		1 to: aNumber - 1 do: [ :j |
			newContents at: i at: j put:
				(self at: i at: j) ] ].
	
	1 to: rows do: [ :i |
		newContents at: i at: aNumber
			put: (anArray at: i) ].
		
	1 to: rows do: [ :i |
		aNumber + 1 to: cols do: [ :j |
			newContents at: i at: j put:
				(self at: i at: j - 1) ] ].
	
	contents := newContents.
]

{ #category : #adding }
DataFrameInternal >> addRow: anArray atPosition: aNumber [

	| rows cols newContents |
	
	rows := self numberOfRows + 1.
	cols := self numberOfColumns.
	
	anArray size = cols
		ifFalse: [ SizeMismatch signal ].
	
	newContents := Array2D
		rows: rows
		columns: cols.
	
	1 to: aNumber - 1 do: [ :i |
		1 to: cols do: [ :j |
			newContents at: i at: j put:
				(self at: i at: j) ] ].
	
	1 to: cols do: [ :j |
		newContents at: aNumber at: j
			put: (anArray at: j) ].
		
	aNumber + 1 to: rows do: [ :i |
		1 to: cols do: [ :j |
			newContents at: i at: j put:
				(self at: i - 1 at: j) ] ].
	
	contents := newContents.
]

{ #category : #converting }
DataFrameInternal >> asArray2D [
	^ contents
]

{ #category : #converting }
DataFrameInternal >> asArrayOfColumns [
	"Converts DataFrameInternal to the array of columns"

	^ (1 to: self numberOfColumns) collect: [ :j |
		(1 to: self numberOfRows) collect: [ :i |
			self at: i at: j ] ].
]

{ #category : #converting }
DataFrameInternal >> asArrayOfRows [
	"Converts DataFrameInternal to the array of rows"

	^ (1 to: self numberOfRows) collect: [ :i |
		(1 to: self numberOfColumns) collect: [ :j |
			self at: i at: j ] ].
]

{ #category : #accessing }
DataFrameInternal >> at: rowIndex at: columnIndex [

	^ contents at: rowIndex at: columnIndex.
]

{ #category : #accessing }
DataFrameInternal >> at: rowIndex at: columnIndex put: value [

	^ contents at: rowIndex at: columnIndex put: value.
]

{ #category : #enumerating }
DataFrameInternal >> collect: aBlock [

	^ self class fromArray2D:
		(contents collect: aBlock).
]

{ #category : #accessing }
DataFrameInternal >> columnAt: aNumber [

	^ (1 to: self numberOfRows) collect: [ :i |
		self at: i at: aNumber ].
]

{ #category : #accessing }
DataFrameInternal >> columnAt: aNumber put: anArray [
"Sets all the values of a given column equal to the values in array. It is assumed that array is of the same size as every column (number of rows). This should be tested in DataFrame"

	(1 to: self numberOfRows) do: [ :i |
		self at: i at: aNumber put: (anArray at: i) ].
]

{ #category : #accessing }
DataFrameInternal >> columnsAt: anArrayOfNumbers [

	| dfInternal numberOfRows numberOfColumns |
	
	numberOfRows := self numberOfRows.
	numberOfColumns := anArrayOfNumbers size.
	dfInternal := DataFrameInternal new: (numberOfRows @ numberOfColumns).
	
	1 to: numberOfRows do: [ :i |
		anArrayOfNumbers doWithIndex: [ :j :k |
			dfInternal at: i at: k put: (self at: i at: j) ] ].
	
	^ dfInternal.
]

{ #category : #copying }
DataFrameInternal >> deepCopy [

	^ self class fromArray2D: contents.
]

{ #category : #enumerating }
DataFrameInternal >> do: aBlock [

	^ contents do: aBlock.
]

{ #category : #initialization }
DataFrameInternal >> initialize [
	
	super initialize.
	contents := Array2D new.
	^ self.
]

{ #category : #initialization }
DataFrameInternal >> initialize: aPoint [
	
	contents := Array2D
		rows: aPoint x
		columns: aPoint y.
		
	^ self.
]

{ #category : #accessing }
DataFrameInternal >> numberOfColumns [

	contents numberOfColumns isNil
		ifTrue: [ ^ 0 ].
		
	^ contents numberOfColumns.
]

{ #category : #accessing }
DataFrameInternal >> numberOfRows [

	contents numberOfRows isNil
		ifTrue: [ ^ 0 ].
		
	^ contents numberOfRows.
]

{ #category : #printing }
DataFrameInternal >> printOn: aStream [

	contents printOn: aStream.
]

{ #category : #removing }
DataFrameInternal >> removeColumnAt: columnNumber [

	| newContents |
	newContents := Array2D
		rows: (self numberOfRows)
		columns: (self numberOfColumns - 1).
		
	1 to: self numberOfRows do: [ :i |
		1 to: columnNumber - 1 do: [ :j |
			newContents at: i at: j put:
				(contents at: i at: j) ].
			
		columnNumber + 1 to: self numberOfColumns do: [ :j |
			newContents at: i at: j - 1 put:
				(contents at: i at: j) ] ].
		
	contents := newContents.
]

{ #category : #removing }
DataFrameInternal >> removeColumnsOfRowElementsSatisfing: aBlock onRow: rowNumber [
	"Executes aBlock for all elements in specified rowNumber and deletes the column
	 which satisfied condition given in aBlock."

	| newContents columnsToDrop k |
	"columnsToDrop has 1 at i if i-th column needs to be dropped, else 0"
	columnsToDrop := (self rowAt: rowNumber) collect: [ :ele |
		(aBlock value: ele) ifTrue: [ true ] ifFalse: [ false ] ].
	
	newContents := Array2D
		rows: (self numberOfRows)
		columns: (self numberOfColumns - (columnsToDrop select: [ :ele | ele ]) size).
	
	(newContents numberOfColumns = 0) ifTrue: [ 
		contents := Array2D rows: 0 columns: 0.
		^ self.
		].
		
	1 to: self numberOfRows do: [ :i |
		k := 0.
		1 to: self numberOfColumns do: [ :j |
			(columnsToDrop at: j)
				ifTrue: [ k := k + 1 ]
				ifFalse: [
				newContents at: i at: j - k put:
					(contents at: i at: j) ]]].
		
	contents := newContents.
]

{ #category : #removing }
DataFrameInternal >> removeRowAt: rowNumber [

	| newContents |
	newContents := Array2D
		rows: (self numberOfRows - 1)
		columns: (self numberOfColumns).
		
	1 to: self numberOfColumns do: [ :j |
		1 to: rowNumber - 1 do: [ :i |
			newContents at: i at: j put:
				(contents at: i at: j) ].
			
		rowNumber + 1 to: self numberOfRows do: [ :i |
			newContents at: i - 1 at: j put:
				(contents at: i at: j) ] ].
		
	contents := newContents.
]

{ #category : #removing }
DataFrameInternal >> removeRowsOfColumnElementsSatisfing: aBlock onColumn: columnNumber [
	"Removes all rows having a nil value at the column columnNumber"

	| newContents rowsToDrop k |
	"rowsToDrop has 1 at i if i-th row needs to be dropped, else 0"
	rowsToDrop := (self columnAt: columnNumber) collect: [ :ele |
		(aBlock value: ele) ifTrue: [ true ] ifFalse: [ false ] ].
	newContents := Array2D
		rows: (self numberOfRows - (rowsToDrop select: [ :ele | ele ]) size)
		columns: (self numberOfColumns).
		
	(newContents numberOfRows = 0) ifTrue: [ 
		contents := Array2D rows: 0 columns: 0.
		^ self.
		].
	
	1 to: self numberOfColumns do: [ :j |
		k := 0.
		1 to: self numberOfRows do: [ :i |
			(rowsToDrop at: i)
				ifTrue: [ k := k + 1 ]
				ifFalse: [
				newContents at: i - k at: j put:
					(contents at: i at: j) ]]].
		
	contents := newContents.
]

{ #category : #filling }
DataFrameInternal >> replaceMissingValuesStrings: aSet [
	"Replaces dataframeinternal values with nil if they are a part of aSet"

	1 to: self numberOfRows do: [ :i |
		1 to: self numberOfColumns do: [ :j |
			(aSet includes: (contents at: i at: j))
				ifTrue: [ contents at: i at: j put: nil ].
			 ] ].
]

{ #category : #accessing }
DataFrameInternal >> rowAt: aNumber [

	^ (1 to: self numberOfColumns) collect: [ :j |
		self at: aNumber at: j ].
]

{ #category : #accessing }
DataFrameInternal >> rowAt: aNumber put: anArray [
"Sets all the values of a given row equal to the values in array. It is assumed that array is of the same size as every row (number of columns). This should be tested in DataFrame"

	(1 to: self numberOfColumns) do: [ :j |
		self at: aNumber at: j put: (anArray at: j) ].
]

{ #category : #accessing }
DataFrameInternal >> rowsAt: anArrayOfNumbers [

	| dfInternal numberOfRows numberOfColumns |
	
	numberOfRows := anArrayOfNumbers size.
	numberOfColumns := self numberOfColumns.
	dfInternal := DataFrameInternal new: (numberOfRows @ numberOfColumns).
	
	anArrayOfNumbers doWithIndex: [ :i :k |
		1 to: numberOfColumns do: [ :j |
			dfInternal at: k at: j put: (self at: i at: j) ] ].
	
	^ dfInternal.
]

{ #category : #enumerating }
DataFrameInternal >> withIndicesCollect: aBlock [

	^ self class fromArray2D:
		(contents withIndicesCollect: aBlock).
]

{ #category : #enumerating }
DataFrameInternal >> withIndicesDo: aBlock [

	^ contents withIndicesDo: aBlock.
]
