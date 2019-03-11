"
I am a tabular data structure designed for data analysis.

I store data in a table and provide an API for querying and modifying that data. I know row and column names associated with the table of data, which allows you to treat rows as observations and columns as features and reference them by their names. I also know the type of data stored in each column. In general, I am similar to spreadsheets such as Excel or to data frames in other languages, for example pandas (Python) or R.

The efficient data structure that I use to store the data is defined by DataFrameInternal. However, you can think of me as a collection of rows. Every time you interact with one of my rows or columns it will be an instance of the DataSeries class. I use DataTypeInductor to induce types of my columns every time they are modified. DataPrettyPrinter allows you to print me as a beautiful string table, DataFrameFTData defines a data source based on myself that is used in FastTable to display me in the inspector. I provide aggregation and grouping fuctionality which is implemented using a helper class DataFrameGrouped.

Public API and Key Messages

	Creating empty data frame (class side):
		- new (empty data frame)
		- new: point (empty data frame with given dimensions)
		- withColumnNames: arrayOfColumnNames (empty data frame with column names)
		- withRowNames: arrayOfRowNames (empty data frame with row names)
		- withRowNames: arrayOfRowNames columnNames: arrayOfColumnNames (empty data frame with row and column names)
		
	Creating data frame from an array of columns (class side):
		- withColumns: arrayOfArrays
		- withColumns: arrayOfArrays columnNames: arrayOfColumnNames
		- withColumns: arrayOfArrays rowNames: arrayOfRowNames
		- withColumns: arrayOfArrays rowNames: arrayOfRowNames columnNames: arrayOfColumnNames
		
	Creating data frame from an array of rows (class side):
		- withRows: arrayOfArrays
		- withRows: arrayOfArrays columnNames: arrayOfColumnNames
		- withRows: arrayOfArrays rowNames: arrayOfRowNames
		- withRows: arrayOfArrays rowNames: arrayOfRowNames columnNames: arrayOfColumnNames

	Converting:
		- asArrayOfColumns
		- asArrayOfRows

	Dimensions
		- numberOfColumns
		- numberOfRows
		- dimensions (a Point numberOfRows @ numberOfColumns)
		
	Column and row names:
		- columnNames 
		- columnNames: arrayOfNewNames
		- rowNames
		- rowNames: arrayOfNewNames
		
	Column types
		- columnTypes (classes of values stored in each column)

	Getting columns:
		- column: columnName 
		- columnAt: index
		- columns: arrayOfColumnNames
		- columnsAt: arrayOfIndices
		- columnsFrom: firstIndex to: lastIndex
		
	Getting rows:
		- row: rowName
		- rowAt: index
		- rows: arrayOfRowNames
		- rowsAt: arrayOfIndices
		- rowsFrom: firstIndex to: lastIndex
		- at: index (same as rowAt:)
		
	Getting a cell value:
		- at: rowIndex at: columnIndex
		
	Setting columns
		- column: columnName put: arrayOrDataSeries
		- columnAt: index put: arrayOrDataSeries
		
	Setting rows
		- row: rowName put: arrayOrDataSeries
		- rowAt: index put: arrayOrDataSeries

	Setting a cell value:
		- at: rowIndex at: columnIndex put: value
		
	Head and tail:
		- head (first 5 rows)
		- head: numberOfRows
		- tail (last 5 rows)
		- tail: numberOfRows
		
	Adding columns:
		- addColumn: dataSeries
		- addColumn: dataSeries atPosition: index
		- addColumn: array named: columnName
		- addColumn: array named: columnName atPosition: index
		- addEmptyColumnNamed: columnName
		- addEmptyColumnNamed: columnName atPosition: index
		
	Adding rows:
		- addRow: dataSeries
		- addRow: dataSeries atPosition: index
		- addRow: array named: rowName
		- addRow: array named: rowName atPosition: index
		- addEmptyRowNamed: rowName
		- addEmptyRowNamed: rowName atPosition: index
		- add: dataSeries (same as addRow:)
		
	Removing columns:
		- removeColumn: columnName
		- removeColumnAt: index
		
	Removing rows: 
		- removeRow: rowName
		- removeRowAt: index
		- removeFirstRow
		- removeLastRow
		
	Enumerating (over rows):
		- collect: block
		- do: block 
		- select: block
		- withKeyDo: block
		
	Aggregating and grouping:
		- groupBy: columnName (returns an instance of DataFrameGrouped)
		- groupBy: columnName aggregate: selector (groups data and aggregates it with a given function)
		- group: columnNameOrArrayOfColumnNames by: columnName (groups part of data frame)
		
	Applying:
		- applyElementwise: block (to all columns)
		- toColumn: columnName applyElementwise: block
		- toColumnAt: index applyElementwise: block
		- toColumns: arrayOfColumnNames applyElementwise: block
		- toColumnsAt: arrayOfIndices applyElementwise: block
		
	Sorting:
		- sortBy: columnName
		- sortDescendingBy: columnName
		- sortBy: columnName using: block
		
	Statistical functions (applied to quantitative columns):
		- min
		- max
		- range (max minus min)
		- average
		- mean
		- mode
		- median (second quartile)
		- first quartile
		- third quartile
		- interquartileRange (trird quartile minus first quartile)
		- stdev (standard deviation)
		- variance
 
Internal Representation and Key Implementation Points.

	DataFrameInternal defines how data is stored inside me.
"
Class {
	#name : #DataFrame,
	#superclass : #Collection,
	#instVars : [
		'contents',
		'rowNames',
		'columnNames'
	],
	#category : #'DataFrame-Core'
}

{ #category : #'instance creation' }
DataFrame class >> new [
	
	^ super new initialize.
]

{ #category : #'instance creation' }
DataFrame class >> new: aPoint [
	
	^ super new initialize: aPoint.
]

{ #category : #'instance creation' }
DataFrame class >> withColumnNames: anArrayOfColumnNames [
	"Create an empty data frame with given column names"
	| numberOfColumns df |
	
	numberOfColumns := anArrayOfColumnNames size.
	df := self new: 0 @ numberOfColumns.
	
	df columnNames: anArrayOfColumnNames.
	^ df
]

{ #category : #'instance creation' }
DataFrame class >> withColumns: anArrayOfArrays [

	^ self new initializeColumns: anArrayOfArrays.
]

{ #category : #'instance creation' }
DataFrame class >> withColumns: anArrayOfArrays columnNames: anArrayOfColumnNames [

	| df |
	df := self withColumns: anArrayOfArrays.
	df columnNames: anArrayOfColumnNames.
	^ df
]

{ #category : #'instance creation' }
DataFrame class >> withColumns: anArrayOfArrays rowNames: anArrayOfRowNames [

	| df |
	df := self withColumns: anArrayOfArrays.
	df rowNames: anArrayOfRowNames.
	^ df
]

{ #category : #'instance creation' }
DataFrame class >> withColumns: anArrayOfArrays rowNames: anArrayOfRowNames columnNames: anArrayOfColumnNames [

	| df |
	df := self withColumns: anArrayOfArrays.
	df rowNames: anArrayOfRowNames.
	df columnNames: anArrayOfColumnNames.
	^ df
]

{ #category : #'instance creation' }
DataFrame class >> withDataFrameInternal: aDataFrameIndernal rowNames: rows columnNames: columns [

	^ self new
		initializeContents: aDataFrameIndernal
		rowNames: rows
		columnNames: columns.
]

{ #category : #'instance creation' }
DataFrame class >> withRowNames: anArrayOfRowNames [
	"Create an empty data frame with given row names"
	| numberOfRows df |
	
	numberOfRows := anArrayOfRowNames size.
	df := self new: numberOfRows @ 0.
	
	df rowNames: anArrayOfRowNames.
	^ df
]

{ #category : #'instance creation' }
DataFrame class >> withRowNames: anArrayOfRowNames columnNames: anArrayOfColumnNames [
	"Create an empty data frame with given row and column names"
	| numberOfRows numberOfColumns df |
	
	numberOfRows := anArrayOfRowNames size.
	numberOfColumns := anArrayOfColumnNames size.
	
	df := self new: numberOfRows @ numberOfColumns.
	
	df rowNames: anArrayOfRowNames.
	df columnNames: anArrayOfColumnNames.
	
	^ df
]

{ #category : #'instance creation' }
DataFrame class >> withRows: anArrayOfArrays [

	^ self new initializeRows: anArrayOfArrays.
]

{ #category : #'instance creation' }
DataFrame class >> withRows: anArrayOfArrays columnNames: anArrayOfColumnNames [

	| df |
	df := self withRows: anArrayOfArrays.
	df columnNames: anArrayOfColumnNames.
	^ df
]

{ #category : #'instance creation' }
DataFrame class >> withRows: anArrayOfArrays rowNames: anArrayOfRowNames [

	| df |
	df := self withRows: anArrayOfArrays.
	df rowNames: anArrayOfRowNames.
	^ df
]

{ #category : #'instance creation' }
DataFrame class >> withRows: anArrayOfArrays rowNames: anArrayOfRowNames columnNames: anArrayOfColumnNames [

	| df |
	df := self withRows: anArrayOfArrays.
	df rowNames: anArrayOfRowNames.
	df columnNames: anArrayOfColumnNames.
	^ df
]

{ #category : #comparing }
DataFrame >> = aDataFrame [

	"Most objects will fail here"
	aDataFrame species = self species
		ifFalse: [ ^ false ].
	
	"This is the fastest way for two data frames with different dimensions"
	aDataFrame dimensions = self dimensions
		ifFalse: [ ^ false ].
	
	"If the names are different we don't need to iterate through values"	
	(aDataFrame rowNames = self rowNames
		and: [ aDataFrame columnNames = self columnNames ])
		ifFalse: [ ^ false ].
		
	^ aDataFrame contents = self contents.
]

{ #category : #adding }
DataFrame >> add: aDataSeries [
	"Add DataSeries as a new row at the end"
	self addRow: aDataSeries.
]

{ #category : #adding }
DataFrame >> addColumn: aDataSeries [
	"Add DataSeries as a new column at the end"
	self addColumn: aDataSeries named: aDataSeries name.
]

{ #category : #adding }
DataFrame >> addColumn: aDataSeries atPosition: aNumber [
	"Add DataSeries as a new column at the given position"
	self addColumn: aDataSeries named: aDataSeries name atPosition: aNumber.
]

{ #category : #adding }
DataFrame >> addColumn: anArray named: aString [
	"Add a new column at the end"
	self addColumn: anArray named: aString atPosition: self numberOfColumns + 1.
]

{ #category : #adding }
DataFrame >> addColumn: anArray named: aString atPosition: aNumber [
	"Add a new column at the given position"
	contents addColumn: anArray atPosition: aNumber.
	columnNames add: aString afterIndex: aNumber - 1.
]

{ #category : #adding }
DataFrame >> addEmptyColumnNamed: aString [
	"Add an empty column at the end"
	self addEmptyColumnNamed: aString atPosition: self numberOfColumns + 1
]

{ #category : #adding }
DataFrame >> addEmptyColumnNamed: aString atPosition: aNumber [
	"Add an empty column at the given position"
	self addColumn: (Array new: self numberOfRows) named: aString atPosition: aNumber
]

{ #category : #adding }
DataFrame >> addEmptyRowNamed: aString [
	"Add an empty row at the end"
	self addEmptyRowNamed: aString atPosition: self numberOfRows + 1
]

{ #category : #adding }
DataFrame >> addEmptyRowNamed: aString atPosition: aNumber [
	"Add an empty row at the given position"
	self addRow: (Array new: self numberOfColumns) named: aString atPosition: aNumber
]

{ #category : #adding }
DataFrame >> addRow: aDataSeries [
	"Add DataSeries as a new row at the end"
	self addRow: aDataSeries named: aDataSeries name.
]

{ #category : #adding }
DataFrame >> addRow: aDataSeries atPosition: aNumber [
	"Add DataSeries as a new row at the given position"
	self addRow: aDataSeries named: aDataSeries name atPosition: aNumber.
]

{ #category : #adding }
DataFrame >> addRow: anArray named: aString [
	"Add a new row at the end"
	self addRow: anArray named: aString atPosition: self numberOfRows + 1.
]

{ #category : #adding }
DataFrame >> addRow: anArray named: aString atPosition: aNumber [
	"Add a new row at the given position"
	contents addRow: anArray atPosition: aNumber.
	rowNames add: aString afterIndex: aNumber - 1.
]

{ #category : #applying }
DataFrame >> applyElementwise: aBlock [
	"Applies a given block to all columns of a data frame"
		
	self toColumns: self columnNames applyElementwise: aBlock.
]

{ #category : #private }
DataFrame >> applyToAllColumns: aSymbol [
"Sends the unary selector, aSymbol, to all columns of DataFrame and collects the result into a DataSeries object. Used by statistical functions of DataFrame"

	| series column |
	
	series := DataSeries withValues:
		(self columnNames collect: [ :colName |
			column := self column: colName.
			column perform: aSymbol ]).
	
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
]

{ #category : #statistics }
DataFrame >> average [

	^ self applyToAllColumns: #average
]

{ #category : #comparing }
DataFrame >> closeTo: aDataFrame [

	aDataFrame species = self species
		ifFalse: [ ^ false ].
	
	aDataFrame dimensions = self dimensions
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

{ #category : #enumerating }
DataFrame >> collect: aBlock [ 
	"Overrides the Collection>>collect to create DataFrame with the same numer of columns as values in the first row"
	| firstRow newDataFrame |
	
	firstRow := (self rowAt: 1) copy.
	newDataFrame := self class new: 0@(aBlock value: firstRow) size.
	newDataFrame columnNames: firstRow keys.
	
	self do: [:each | newDataFrame add: (aBlock value: each copy)].
	^ newDataFrame
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
]

{ #category : #accessing }
DataFrame >> columnNames [

	^ columnNames
]

{ #category : #accessing }
DataFrame >> columnNames: anArray [
	anArray size = self numberOfColumns 
		ifFalse: [ SizeMismatch signal: 'Wrong number of column names' ].
		
	columnNames := anArray asOrderedCollection
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
		withDataFrameInternal: (self contents columnsAt: anArrayOfNumbers)
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
DataFrame >> defaultHeadTailSize [

	^ 5
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

	^ self applyToAllColumns: #firstQuartile
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

{ #category : #'gt-inspector-extension' }
DataFrame >> gtInspectorFastTableIn: composite [
	<gtInspectorPresentationOrder: 0>
	<gtInspectorTag: #basic>
	
	composite morph
		title: 'Fast Table';
		display: [ self showWithGlamourIn: composite ].
]

{ #category : #'gt-inspector-extension' }
DataFrame >> gtInspectorItemsIn: composite [
"Hide Items from inspector"

	composite fastTable
		when: [ false ].
]

{ #category : #accessing }
DataFrame >> head [ 

	^ self head: self defaultHeadTailSize.
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

{ #category : #initialization }
DataFrame >> initialize [

	super initialize.
	
	contents := DataFrameInternal new.
	self setDefaultRowColumnNames.
]

{ #category : #initialization }
DataFrame >> initialize: aPoint [

	super initialize.
	
	contents := DataFrameInternal new: aPoint.
	self setDefaultRowColumnNames.
]

{ #category : #initialization }
DataFrame >> initializeColumns: anArrayOfArrays [

	contents := DataFrameInternal withColumns: anArrayOfArrays.
	self setDefaultRowColumnNames.
]

{ #category : #initialization }
DataFrame >> initializeContents: aDataFrameInternal rowNames: rows columnNames: columns [

	super initialize.
	
	contents := aDataFrameInternal.
	self rowNames: rows.
	self columnNames: columns.
]

{ #category : #initialization }
DataFrame >> initializeRows: anArrayOfArrays [

	contents := DataFrameInternal withRows: anArrayOfArrays.
	self setDefaultRowColumnNames.
]

{ #category : #statistics }
DataFrame >> interquartileRange [

	^ self applyToAllColumns: #interquartileRange
]

{ #category : #statistics }
DataFrame >> max [

	^ self applyToAllColumns: #max
]

{ #category : #statistics }
DataFrame >> median [

	^ self applyToAllColumns: #median
]

{ #category : #statistics }
DataFrame >> min [

	^ self applyToAllColumns: #min
]

{ #category : #statistics }
DataFrame >> mode [

	^ self applyToAllColumns: #mode
]

{ #category : #accessing }
DataFrame >> numberOfColumns [

	^ contents numberOfColumns
]

{ #category : #accessing }
DataFrame >> numberOfRows [

	^ contents numberOfRows
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

{ #category : #statistics }
DataFrame >> range [

	^ self applyToAllColumns: #range
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
]

{ #category : #accessing }
DataFrame >> rowNames [

	^ rowNames
]

{ #category : #accessing }
DataFrame >> rowNames: anArray [
	anArray size = self numberOfRows 
		ifFalse: [ SizeMismatch signal: 'Wrong number of row names' ].
		
	rowNames := anArray asOrderedCollection
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
		withDataFrameInternal: (self contents rowsAt: anArrayOfNumbers)
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
	
	df := self class withRows: selectedRows.
	df columnNames: self columnNames.
	df rowNames: (selectedRows collect: #name).
	
	^ df
]

{ #category : #private }
DataFrame >> setDefaultRowColumnNames [

	self rowNames: (1 to: self numberOfRows) asOrderedCollection.
	self columnNames: (1 to: self numberOfColumns) asOrderedCollection.
]

{ #category : #'gt-inspector-extension' }
DataFrame >> showWithGlamourIn: composite [
	| table headerNames |
	table := FTTableMorph new.
	"extent: 650@500"
	table
		beResizable;
		intercellSpacing: 1;
		dataSource: (DataFrameFTData elements: self);
		onAnnouncement: FTSelectionChanged
			do: [ :ann | (self rowAt: ann newSelectedIndexes first) inspect ].

	"		onAnnouncement: FTSelectionChanged 
			do: [ :ann | (self rowsAt: ann newSelectedRowIndexes) gtInspectorItemsIn: composite ];"
	headerNames := #('#') , self columnNames.
	table
		columns: (headerNames collect: [ :name | (FTColumn id: name) width: 100 ]).
	^ table
]

{ #category : #sorting }
DataFrame >> sortBy: columnName [
	self sortBy: columnName using: [ :a :b | a <= b ]
]

{ #category : #sorting }
DataFrame >> sortBy: columnName using: aBlock [

	| column sortedKeys newContents |
	column := self column: columnName.
	column := column copy.
	column sortUsing: aBlock.
	sortedKeys := column keys.
	
	newContents := DataFrameInternal new: self dimensions.
	
	sortedKeys withIndexDo: [ :key :i |
		newContents rowAt: i put: (self row: key) ].
		
	contents := newContents.
	self rowNames: sortedKeys.
]

{ #category : #sorting }
DataFrame >> sortDescendingBy: columnName [
	self sortBy: columnName using: [ :a :b | a >= b ].
]

{ #category : #statistics }
DataFrame >> stdev [

	^ self applyToAllColumns: #stdev
]

{ #category : #accessing }
DataFrame >> tail [

	^ self tail: self defaultHeadTailSize.
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

	^ self applyToAllColumns: #thirdQuartile
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

{ #category : #geometry }
DataFrame >> transposed [
	"Returs a transposed DataFrame. Columns become rows and rows become columns."

	| transposedDf |
	transposedDf := DataFrame withRows: (self asArrayOfColumns).
	transposedDf rowNames: self columnNames.
	transposedDf columnNames: self rowNames.
	^ transposedDf
]

{ #category : #statistics }
DataFrame >> variance [

	^ self applyToAllColumns: #variance
]

{ #category : #enumerating }
DataFrame >> withKeyDo: elementAndKeyBlock [

	1 to: self size do: [ :index |
		elementAndKeyBlock
			value: (self rowAt: index)
			value: (rowNames at: index) ].
]
