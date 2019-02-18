"
I am a collection for datasets that can be stored and processed in tables. I am suitable for data analysis.
"
Class {
	#name : #DataFrame,
	#superclass : #Collection,
	#traits : 'TDataSlicer',
	#classTraits : 'TDataSlicer classTrait',
	#instVars : [
		'contents',
		'rowNames',
		'columnNames',
		'columnTypes'
	],
	#category : #'DataFrame-Core'
}

{ #category : #'as yet unclassified' }
DataFrame class >> emptyWithColumnNames: aCollection [ 
	| df |
	df := self new: 0@(aCollection size).
	df columnNames: aCollection.
	^ df
]

{ #category : #'instance creation' }
DataFrame class >> fromColumns: anArrayOfArrays [

	^ self new initializeColumns: anArrayOfArrays.
]

{ #category : #'instance creation' }
DataFrame class >> fromContents: aDataFrameIndernal rowNames: rows columnNames: columns [

	^ self new
		initializeContents: aDataFrameIndernal
		rowNames: rows
		columnNames: columns.
]

{ #category : #'instance creation' }
DataFrame class >> fromMatrix: aMatrix [

	^ self new initializeMatrix: aMatrix.
]

{ #category : #'instance creation' }
DataFrame class >> fromRows: anArrayOfArrays [

	^ self new initializeRows: anArrayOfArrays.
]

{ #category : #'instance creation' }
DataFrame class >> new [
	
	^ super new initialize.
]

{ #category : #'instance creation' }
DataFrame class >> new: aPoint [
	
	^ super new initialize: aPoint.
]

{ #category : #comparing }
DataFrame >> = aDataFrame [

	"Most objects will fail here"
	aDataFrame species = self species
		ifFalse: [ ^ false ].
	
	"This is the fastest way for two data frames with different dimensions"
	aDataFrame dimensions = self dimensions
		ifFalse: [ ^ false ].
		
	"If column types are different, we don't need to iterate through row and column names"
	aDataFrame columnTypes = self columnTypes
		ifFalse: [ ^ false ].
	
	"If the names are different we don't need to iterate through values"	
	(aDataFrame rowNames = self rowNames
		and: [ aDataFrame columnNames = self columnNames ])
		ifFalse: [ ^ false ].
		
	^ aDataFrame contents = self contents.
]

{ #category : #adding }
DataFrame >> addEmptyColumnNamed: aColumnName [
"Create an empty column with a given name at the end of DataFrame. The values of a new column will be set equal to nil"

	self
		atColumn: aColumnName
		put: (Array new: self numberOfRows).
]

{ #category : #adding }
DataFrame >> addRow: anArray named: rowName [

	contents addRow: anArray.
	rowNames := rowNames copyWith: rowName.
	self induceColumnTypes.
]

{ #category : #applying }
DataFrame >> applyElementwise: aBlock [
	"Applies a given block to all columns of a data frame"
		
	self toColumns: self columnNames applyElementwise: aBlock.
]

{ #category : #private }
DataFrame >> applyToQuantitativeColumns: aSymbol [
"Sends the unary selector, aSymbol, to all the quantitative columns of DataFrame and collects the result into a DataSeries object. Used by statistical functions of DataFrame"

	| series column |
	
	series := DataSeries fromArray:
		(self columnNames collect: [ :colName |
			column := self column: colName.
			
			column isQuantitative
				ifTrue: [ column perform: aSymbol ]
				ifFalse: [ Float nan ] ]).
	
	series name: aSymbol.
	series keys: self columnNames.
	
	^ series
]

{ #category : #converting }
DataFrame >> asArrayOfColumns [
	"Converts DataFrame to the array of columns"

	^ contents asArrayOfColumns. 
]

{ #category : #converting }
DataFrame >> asArrayOfRows [
	"Converts DataFrame to the array of rows"
	
	^ (1 to: self numberOfRows) collect: [ :i |
		self at: i ]
]

{ #category : #printing }
DataFrame >> asStringTable [

	| stream |
	stream := String new writeStream.
	DataPrettyPrinter new print: self on: stream.
	^ stream contents
]

{ #category : #accessing }
DataFrame >> at: aNumber [

	^ self rowAt: aNumber
]

{ #category : #accessing }
DataFrame >> at: rowNumber at: columnNumber [

	^ contents at: rowNumber at: columnNumber
]

{ #category : #accessing }
DataFrame >> at: rowNumber at: columnNumber put: value [

	contents at: rowNumber at: columnNumber put: value.
	self induceColumnTypeAt: columnNumber.
]

{ #category : #adding }
DataFrame >> atColumn: aColumnName put: anArray [
	contents addColumn: anArray.
	columnNames := columnNames copyWith: aColumnName.
	
	columnTypes := columnTypes copyWith: nil. "Extend an array"
	self induceColumnTypeAt: (self numberOfColumns).
]

{ #category : #statistics }
DataFrame >> average [

	^ self applyToQuantitativeColumns: #average
]

{ #category : #accessing }
DataFrame >> categoricalColumns [

	^ self columnNames select: [ :colName |
		(self column: colName) isCategorical ]
]

{ #category : #comparing }
DataFrame >> closeTo: aDataFrame [

	aDataFrame species = self species
		ifFalse: [ ^ false ].
	
	aDataFrame dimensions = self dimensions
		ifFalse: [ ^ false ].
		
	aDataFrame columnTypes = self columnTypes
		ifFalse: [ ^ false ].
		
	(aDataFrame rowNames = self rowNames
		and: [ aDataFrame columnNames = self columnNames ])
		ifFalse: [ ^ false ].
		
	1 to: self numberOfRows do: [ :i |
		1 to: self numberOfColumns do: [ :j |
			((self at: i at: j) closeTo: (aDataFrame at: i at: j))
				ifFalse: [ ^ false ] ] ].
	
	^ true
]

{ #category : #accessing }
DataFrame >> column: columnName [

	| index |
	index := self indexOfColumnNamed: columnName.
	^ self columnAt: index
]

{ #category : #accessing }
DataFrame >> column: columnName put: anArray [

	| index |
	index := self indexOfColumnNamed: columnName.
	^ self columnAt: index put: anArray.
]

{ #category : #accessing }
DataFrame >> columnAt: aNumber [

	| series |
	series := (contents columnAt: aNumber) asDataSeries.
	series name: (self columnNames at: aNumber).
	series keys: self rowNames.
	^ series
]

{ #category : #accessing }
DataFrame >> columnAt: aNumber put: anArray [
	
	anArray size = self numberOfRows
		ifFalse: [ SizeMismatch signal ].	
	
	contents columnAt: aNumber put: anArray.
	self induceColumnTypeAt: aNumber.
]

{ #category : #accessing }
DataFrame >> columnNames [

	^ columnNames
]

{ #category : #accessing }
DataFrame >> columnNames: anArray [

	columnNames := anArray.
]

{ #category : #accessing }
DataFrame >> columnTypes [

	^ columnTypes.
]

{ #category : #accessing }
DataFrame >> columns: anArrayOfNames [
	
	| anArrayOfNumbers |
	
	anArrayOfNumbers := anArrayOfNames
		collect: [ :name |
			self indexOfColumnNamed: name ].
			
	^ self columnsAt: anArrayOfNumbers.
]

{ #category : #accessing }
DataFrame >> columnsAt: anArrayOfNumbers [

	| newColumnNames |
	
	newColumnNames := (anArrayOfNumbers collect: [ :i |
		self columnNames at: i ]).

	^ DataFrame
		fromContents: (self contents columnsAt: anArrayOfNumbers)
		rowNames: self rowNames
		columnNames: newColumnNames.
]

{ #category : #accessing }
DataFrame >> columnsFrom: begin to: end [

	| array |
	
	array := begin < end
		ifTrue: [ (begin to: end) asArray ]
		ifFalse: [ (end to: begin) asArray reverse ].
	
	^ self columnsAt: array.
]

{ #category : #accessing }
DataFrame >> contents [

	^ contents
]

{ #category : #accessing }
DataFrame >> crossTabulate: colName1 with: colName2 [

	| col1 col2 |
	
	col1 := self column: colName1.
	col2 := self column: colName2.
	
	^ col1 crossTabulateWith: col2.
]

{ #category : #accessing }
DataFrame >> dimensions [

	^ (self numberOfRows) @ (self numberOfColumns)
]

{ #category : #enumerating }
DataFrame >> do: aBlock [
"We enumerate through the data enrties - through rows of a data frame"

	1 to: self numberOfRows do: [ :i |
		aBlock value: (self rowAt: i) ].
]

{ #category : #statistics }
DataFrame >> firstQuartile [

	^ self applyToQuantitativeColumns: #firstQuartile
]

{ #category : #queries }
DataFrame >> group: colNameOrArray by: colName [

	| left right |
	
	left := colNameOrArray isArray
		ifTrue: [ self columns: colNameOrArray ]	"a DataFrame"
		ifFalse: [ self column: colNameOrArray ].	"a DataSeries"
		
	right := self column: colName.
	
	^ left groupBy: right.
]

{ #category : #queries }
DataFrame >> groupBy: colName [

	| groupedColNames |
	
	"We exclude the column by which we are grouping"
	groupedColNames := self columnNames copyWithout: colName.

	^ DataFrameGrouped
		group: (self columns: groupedColNames)
		by: (self column: colName)
]

{ #category : #queries }
DataFrame >> groupBy: colName aggregate: selector [

	^ (self groupBy: colName) perform: selector.
]

{ #category : #inspector }
DataFrame >> gtInspectorFastTableIn: composite [
	<gtInspectorPresentationOrder: 0>
	<gtInspectorTag: #basic>
	
	composite morph
		title: 'Fast Table';
		display: [ self showWithGlamourIn: composite ].
]

{ #category : #inspector }
DataFrame >> gtInspectorItemsIn: composite [
"Hide Items from inspector"

	composite fastTable
		when: [ false ].
]

{ #category : #accessing }
DataFrame >> head: aNumber [

	| n |
	
	self numberOfRows  > aNumber
		ifTrue: [ n := aNumber ]
		ifFalse: [ n := self numberOfRows ].
		
	^ self rowsAt: (1 to: n).
]

{ #category : #private }
DataFrame >> indexOfColumnNamed: columnName [

	| index |
	index := self columnNames indexOf: columnName.
	
	"If a column with that name does not exist"
	index = 0
		ifTrue: [ NotFoundError signal:
			('Column ', columnName, ' was not found') ].
		
	^ index
]

{ #category : #private }
DataFrame >> indexOfRowNamed: rowName [

	| index |
	index := self rowNames indexOf: rowName.
	
	"If a row with that name does not exist"
	index = 0
		ifTrue: [ NotFoundError signal:
			('Row ', rowName, ' was not found') ].
		
	^ index
]

{ #category : #accessing }
DataFrame >> induceColumnTypeAt: aNumber [
"Indeces the least common superclass for all values of a column of given by its number"

	| inductor type |
	inductor := DataTypeInductor new.
	type := inductor typeOf: (self columnAt: aNumber).
	
	columnTypes at: aNumber put: type.
]

{ #category : #'as yet unclassified' }
DataFrame >> induceColumnTypes [
"Indeces the least common superclass for all the values in each column of a data frame"

	| inductor |
	inductor := DataTypeInductor new.
	
	columnTypes := inductor columnTypesOf: self.
]

{ #category : #initialization }
DataFrame >> initialize [

	super initialize.
	
	contents := DataFrameInternal new.
	self setDefaultRowColumnNames.
	self induceColumnTypes.
]

{ #category : #initialization }
DataFrame >> initialize: aPoint [

	super initialize.
	
	contents := DataFrameInternal new: aPoint.
	self setDefaultRowColumnNames.
	self induceColumnTypes.
]

{ #category : #initialization }
DataFrame >> initializeColumns: anArrayOfArrays [

	contents := DataFrameInternal fromColumns: anArrayOfArrays.
	self setDefaultRowColumnNames.
	self induceColumnTypes.
]

{ #category : #initialization }
DataFrame >> initializeContents: aDataFrameInternal rowNames: rows columnNames: columns [

	super initialize.
	
	contents := aDataFrameInternal.
	self rowNames: rows.
	self columnNames: columns.
	self induceColumnTypes.
]

{ #category : #initialization }
DataFrame >> initializeMatrix: aMatrix [

	contents := DataFrameInternal fromMatrix: aMatrix.
	self setDefaultRowColumnNames.
	self induceColumnTypes.
]

{ #category : #initialization }
DataFrame >> initializeRows: anArrayOfArrays [

	contents := DataFrameInternal fromRows: anArrayOfArrays.
	self setDefaultRowColumnNames.
	self induceColumnTypes.
]

{ #category : #statistics }
DataFrame >> interquartileRange [

	^ self applyToQuantitativeColumns: #interquartileRange
]

{ #category : #statistics }
DataFrame >> max [

	^ self applyToQuantitativeColumns: #max
]

{ #category : #statistics }
DataFrame >> mean [

	^ self applyToQuantitativeColumns: #mean
]

{ #category : #statistics }
DataFrame >> median [

	^ self applyToQuantitativeColumns: #median
]

{ #category : #statistics }
DataFrame >> min [

	^ self applyToQuantitativeColumns: #min
]

{ #category : #statistics }
DataFrame >> mode [

	^ self applyToQuantitativeColumns: #mode
]

{ #category : #accessing }
DataFrame >> numberOfColumns [

	^ contents numberOfColumns
]

{ #category : #accessing }
DataFrame >> numberOfRows [

	^ contents numberOfRows
]

{ #category : #sorting }
DataFrame >> orderBy: columnName [

	self orderBy: columnName using: [ :a :b | a <= b ].
]

{ #category : #sorting }
DataFrame >> orderBy: columnName using: aBlock [

	| column sortedKeys newContents |
	column := self column: columnName.
	column sort: aBlock.
	sortedKeys := column keys.
	
	newContents := DataFrameInternal new: self dimensions.
	
	1 to: self numberOfRows do: [ :i |
		newContents rowAt: i put:
			(self row: (sortedKeys at: i)) ].
		
	contents := newContents.
	self rowNames: sortedKeys.
]

{ #category : #sorting }
DataFrame >> orderDescendingBy: columnName [

	self orderBy: columnName using: [ :a :b | a >= b ].
]

{ #category : #printing }
DataFrame >> printOn: aStream [

	| title |
	title := self class name.
	aStream
		nextPutAll: (title first isVowel ifTrue: ['an '] ifFalse: ['a ']);
		nextPutAll: title;
		space;
		nextPutAll: self dimensions asString.
]

{ #category : #accessing }
DataFrame >> quantitativeColumns [

	^ self columnNames select: [ :colName |
		(self column: colName) isQuantitative ]
]

{ #category : #statistics }
DataFrame >> range [

	^ self applyToQuantitativeColumns: #range
]

{ #category : #removing }
DataFrame >> removeColumn: columnName [

	| index |
	index := self indexOfColumnNamed: columnName.
	self removeColumnAt: index.
]

{ #category : #removing }
DataFrame >> removeColumnAt: columnNumber [

	contents removeColumnAt: columnNumber.
	columnNames := columnNames copyWithoutIndex: columnNumber.
	columnTypes := columnTypes copyWithoutIndex: columnNumber.
]

{ #category : #removing }
DataFrame >> removeFirstRow [

	self removeRowAt: 1.

	
]

{ #category : #removing }
DataFrame >> removeLastRow [

	self removeRowAt: (self numberOfRows).

	
]

{ #category : #removing }
DataFrame >> removeRow: rowName [

	| index |
	index := self indexOfRowNamed: rowName.
	self removeRowAt: index.
]

{ #category : #removing }
DataFrame >> removeRowAt: rowNumber [

	contents removeRowAt: rowNumber.
	rowNames := rowNames copyWithoutIndex: rowNumber.
	self induceColumnTypes.
]

{ #category : #accessing }
DataFrame >> row: rowName [

	| index |
	index := self indexOfRowNamed: rowName.
	^ self rowAt: index
]

{ #category : #accessing }
DataFrame >> row: rowName put: anArray [

	| index |
	index := self indexOfRowNamed: rowName.
	^ self rowAt: index put: anArray.
]

{ #category : #accessing }
DataFrame >> rowAt: aNumber [

	| series |
	series := (contents rowAt: aNumber) asDataSeries.
	series name: (self rowNames at: aNumber).
	series keys: self columnNames.
	^ series
]

{ #category : #accessing }
DataFrame >> rowAt: aNumber put: anArray [

	anArray size = self numberOfColumns
		ifFalse: [ SizeMismatch signal ].
		
	contents rowAt: aNumber put: anArray.
	self induceColumnTypes.
]

{ #category : #accessing }
DataFrame >> rowNames [

	^ rowNames
]

{ #category : #accessing }
DataFrame >> rowNames: anArray [

	rowNames := anArray
]

{ #category : #accessing }
DataFrame >> rows: anArrayOfNames [
	
	| anArrayOfNumbers |
	
	anArrayOfNumbers := anArrayOfNames
		collect: [ :name |
			self indexOfRowNamed: name ].
			
	^ self rowsAt: anArrayOfNumbers.
]

{ #category : #accessing }
DataFrame >> rowsAt: anArrayOfNumbers [

	| newRowNames |
	
	newRowNames := (anArrayOfNumbers collect: [ :i |
		self rowNames at: i ]).

	^ DataFrame
		fromContents: (self contents rowsAt: anArrayOfNumbers)
		rowNames: newRowNames
		columnNames: self columnNames.
]

{ #category : #accessing }
DataFrame >> rowsFrom: begin to: end [

	^ self rowsAt: (begin to: end).
]

{ #category : #enumerating }
DataFrame >> select: aBlock [ 
	"Evaluate aBlock with each of the receiver's elements as the argument. 
	Collect into a new collection like the receiver, only those elements for 
	which aBlock evaluates to true. Answer the new collection."

	| rows selectedRows df |
	
	rows := self asArrayOfRows.
	selectedRows := rows select: aBlock.
	
	df := self class fromRows: selectedRows.
	df columnNames: self columnNames.
	df rowNames: (selectedRows collect: #name).
	
	^ df
]

{ #category : #private }
DataFrame >> setDefaultRowColumnNames [

	self rowNames: (1 to: self numberOfRows) asArray.
	self columnNames: (1 to: self numberOfColumns) asArray.
]

{ #category : #inspector }
DataFrame >> showWithGlamourIn: composite [
	| table headerNames |

	table := FTTableMorph new
		"extent: 650@500".
	
	table
		beResizable;
		intercellSpacing: 1;
		dataSource: (DataFrameFTData elements: self);
		onAnnouncement: FTSelectionChanged 
			do: [ :ann | (self rowAt: ann newSelectedRowIndexes first) inspect ].
		
"		onAnnouncement: FTSelectionChanged 
			do: [ :ann | (self rowsAt: ann newSelectedRowIndexes) gtInspectorItemsIn: composite ];"
		
	headerNames := #('#'), self columnNames.
	table columns: (headerNames collect: [ :name |
		(FTColumn id: name) width: 100 ]).
	
	^ table
]

{ #category : #statistics }
DataFrame >> stdev [

	^ self applyToQuantitativeColumns: #stdev
]

{ #category : #accessing }
DataFrame >> tail: aNumber [

	| n rows |
	
	rows := self numberOfRows.
	
	rows > aNumber
		ifTrue: [ n := aNumber ]
		ifFalse: [ n := rows ].
			
	^ self rowsAt: ((rows - n + 1) to: rows).
]

{ #category : #statistics }
DataFrame >> thirdQuartile [

	^ self applyToQuantitativeColumns: #thirdQuartile
]

{ #category : #applying }
DataFrame >> toColumn: columnName applyElementwise: aBlock [
		
	| index |
	index := self columnNames indexOf: columnName.
	
	"If a column with that name does not exist"
	index = 0
		ifTrue: [ NotFoundError signal ].
		
	self toColumnAt: index applyElementwise: aBlock.
]

{ #category : #applying }
DataFrame >> toColumnAt: columnNumber applyElementwise: aBlock [
		
	1 to: self numberOfRows do: [ :i |
		contents at: i at: columnNumber put:
			(aBlock value: (contents at: i at: columnNumber)) ].
		
	self induceColumnTypeAt: columnNumber.
]

{ #category : #applying }
DataFrame >> toColumns: arrayOfColumnNames applyElementwise: aBlock [
		
	arrayOfColumnNames do: [ :each |
		self toColumn: each applyElementwise: aBlock ].
]

{ #category : #applying }
DataFrame >> toColumnsAt: arrayOfColumnNumbers applyElementwise: aBlock [
		
	arrayOfColumnNumbers do: [ :each |
		self toColumnAt: each applyElementwise: aBlock ].
]

{ #category : #'as yet unclassified' }
DataFrame >> toCsv: path [

	self toCsv: path separator: ','.
]

{ #category : #'as yet unclassified' }
DataFrame >> toCsv: path separator: sep [

	| stream |
	
	stream := FileStream newFileNamed: path. 
	
	1 to: (columnNames size - 1) do: [ :i |
		stream
			nextPutAll: (columnNames at: i) asString;
		 	nextPutAll: sep ].
	
	stream
		nextPutAll: columnNames last asString;
		cr.
	
	self do: [ :row |
		1 to: (row size - 1) do: [ :i |
			stream
				nextPutAll: (row at: i) asString;
				nextPutAll: sep. ].
			
		stream
			nextPutAll: row last asString;
			cr ].
	stream close. 
]

{ #category : #geometry }
DataFrame >> transposed [
	"Returs a transposed DataFrame. Columns become rows and rows become columns."

	| transposedDf |
	transposedDf := DataFrame fromRows: (self asArrayOfColumns).
	transposedDf rowNames: self columnNames.
	transposedDf columnNames: self rowNames.
	^ transposedDf
]

{ #category : #statistics }
DataFrame >> variance [

	^ self applyToQuantitativeColumns: #variance
]

{ #category : #enumerating }
DataFrame >> withKeyDo: elementAndKeyBlock [

	1 to: self size do: [ :index |
		elementAndKeyBlock
			value: (self rowAt: index)
			value: (rowNames at: index) ].
]
