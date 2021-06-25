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
	^ anArrayOfArrays
		ifNotEmpty: [ (self withColumns: anArrayOfArrays)
				rowNames: anArrayOfRowNames;
				yourself ]
		ifEmpty: [ self withRowNames: anArrayOfRowNames ]
]

{ #category : #'instance creation' }
DataFrame class >> withColumns: anArrayOfArrays rowNames: anArrayOfRowNames columnNames: anArrayOfColumnNames [
	^ anArrayOfArrays
		ifNotEmpty: [ (self withColumns: anArrayOfArrays)
				rowNames: anArrayOfRowNames;
				columnNames: anArrayOfColumnNames;
				yourself ]
		ifEmpty: [ self withRowNames: anArrayOfRowNames ]
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
	^ anArrayOfArrays
		ifNotEmpty: [ (self withRows: anArrayOfArrays)
				columnNames: anArrayOfColumnNames;
				yourself ]
		ifEmpty: [ self withColumnNames: anArrayOfColumnNames ]
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
	^ anArrayOfArrays
		ifNotEmpty: [ (self withRows: anArrayOfArrays)
				rowNames: anArrayOfRowNames;
				columnNames: anArrayOfColumnNames;
				yourself ]
		ifEmpty: [ self withColumnNames: anArrayOfColumnNames ]
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
	self addColumn: aDataSeries asArray named: aDataSeries name atPosition: aNumber.
]

{ #category : #adding }
DataFrame >> addColumn: anArray named: aString [
	"Add a new column at the end"
	self addColumn: anArray named: aString atPosition: self numberOfColumns + 1.
]

{ #category : #adding }
DataFrame >> addColumn: anArray named: aString atPosition: aNumber [
	"Add a new column at the given position"
	(self columnNames includes: aString)
		ifTrue: [ Error signal: 'A column with that name already exists' ].
	
	contents addColumn: anArray asArray atPosition: aNumber.
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
	self addRow: aDataSeries asArray named: aDataSeries name.
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
	(self rowNames includes: aString)
		ifTrue: [ Error signal: 'A row with that name already exists' ].
	
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

{ #category : #accessing }
DataFrame >> at: rowIndex at: columnIndex transform: aBlock [
	"Evaluate aBlock on the value at the intersection of rowIndex and columnIndex and replace that value with the result"
	| value |
	value := self at: rowIndex at: columnIndex.
	self at: rowIndex at: columnIndex put: (aBlock value: value)
]

{ #category : #accessing }
DataFrame >> at: aNumber transform: aBlock [
	"Evaluate aBlock on the row at aNumber and replace that row with the result"
	^ self rowAt: aNumber transform: aBlock
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
	"Overrides the Collection>>collect to create DataFrame with the same number of columns as values in the first row"
	| firstRow newDataFrame |
	
	firstRow := aBlock value: (self rowAt: 1) copy.
	newDataFrame := self class new: 0@firstRow size.
	newDataFrame columnNames: firstRow keys.
	
	self do: [:each | newDataFrame add: (aBlock value: each copy)].
	^ newDataFrame
]

{ #category : #accessing }
DataFrame >> column: columnName [
	"Answer the column with columnName as a DataSeries or signal an exception if a column with that name was not found"
	| index |
	index := self indexOfColumnNamed: columnName.
	^ self columnAt: index
]

{ #category : #accessing }
DataFrame >> column: columnName ifAbsent: exceptionBlock [
	"Answer the column with columnName as a DataSeries or evaluate exception block if a column with that name was not found"
	| index |
	index := self
		indexOfColumnNamed: columnName
		ifAbsent: [ ^ exceptionBlock value ].
		
	^ self columnAt: index
]

{ #category : #accessing }
DataFrame >> column: columnName put: anArray [
	"Replace the current values of column with columnName with anArray or signal an exception if a column with that name was not found"
	| index |
	index := self indexOfColumnNamed: columnName.
	^ self columnAt: index put: anArray.
]

{ #category : #accessing }
DataFrame >> column: columnName put: anArray ifAbsent: exceptionBlock [
	"Replace the current values of column with columnName with anArray or evaluate exception block if a column with that name was not found"
	| index |
	index := self
		indexOfColumnNamed: columnName
		ifAbsent: [ ^ exceptionBlock value ].
		
	^ self columnAt: index put: anArray
]

{ #category : #accessing }
DataFrame >> column: columnName transform: aBlock [
	"Evaluate aBlock on the column with columnName and replace column with the result. Signal an exception if columnName was not found"
	| column |
	column := self column: columnName.
	self column: columnName put: (aBlock value: column) asArray
]

{ #category : #accessing }
DataFrame >> column: columnName transform: aBlock ifAbsent: exceptionBlock [
	"Evaluate aBlock on the column with columnName and replace column with the result. Evaluate exceptionBlock if columnName was not found"
	| column |
	column := self column: columnName ifAbsent: [ ^ exceptionBlock value ].
	self column: columnName put: (aBlock value: column)
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
DataFrame >> columnAt: aNumber transform: aBlock [
	"Evaluate aBlock on the column at aNumber and replace that column with the result"
	| column |
	column := self columnAt: aNumber.
	self columnAt: aNumber put: (aBlock value: column) asArray
]

{ #category : #accessing }
DataFrame >> columnNames [

	^ columnNames
]

{ #category : #accessing }
DataFrame >> columnNames: anArray [
	anArray size = self numberOfColumns 
		ifFalse: [ SizeMismatch signal: 'Wrong number of column names' ].
		
	anArray asSet size = anArray size
		ifFalse: [ Error signal: 'All column names must be distinct' ].
		
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
DataFrame >> columns: anArrayOfColumnNames put: anArrayOfArrays [
	
	anArrayOfArrays size = anArrayOfColumnNames size
		ifFalse: [ SizeMismatch signal ].	
	
	anArrayOfColumnNames with: anArrayOfArrays do: [ :name :array |
		self column: name put: array ].
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
DataFrame >> columnsAt: anArrayOfNumbers put: anArrayOfArrays [
	
	anArrayOfArrays size = anArrayOfNumbers size
		ifFalse: [ SizeMismatch signal ].	
	
	anArrayOfNumbers with: anArrayOfArrays do: [ :index :array |
		self columnAt: index put: array ].
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
DataFrame >> columnsFrom: firstNumber to: secondNumber put: anArrayOfArrays [

	| interval |
	
	anArrayOfArrays size = ((firstNumber - secondNumber) abs + 1)
		ifFalse: [ SizeMismatch signal ].	
			
	interval := secondNumber >= firstNumber
		ifTrue: [ (firstNumber to: secondNumber) ]
		ifFalse: [ (secondNumber to: firstNumber) reversed ].
	
	interval withIndexDo: [ :columnIndex :i |
		self columnAt: columnIndex put: (anArrayOfArrays at: i) ].
]

{ #category : #accessing }
DataFrame >> contents [

	^ contents
]

{ #category : #statistics }
DataFrame >> correlationMatrix [
	"Calculate a correlation matrix (correlation of every column with every column) using Pearson's correlation coefficient"
	^ self correlationMatrixUsing: DataPearsonCorrelationCoefficient
]

{ #category : #statistics }
DataFrame >> correlationMatrixUsing: aCorrelationCoefficient [
	"Calculate a correlation matrix (correlation of every column with every column) using the given correlation coefficient"
	
	| numericalColumnNames correlationMatrix firstColumn secondColumn correlation |
	
	numericalColumnNames := self columnNames select: [ :columnName |
		(self column: columnName) isNumerical ].
	
	numericalColumnNames ifEmpty: [
		Error signal: 'This data frame does not have any numerical columns' ].
	
	correlationMatrix := self class
		withRowNames: numericalColumnNames
		columnNames: numericalColumnNames.
		
	1 to: numericalColumnNames size do: [ :i |
		1 to: i - 1 do: [ :j |
			firstColumn := self column: (numericalColumnNames at: i).
			secondColumn := self column: (numericalColumnNames at: j).
			correlation := firstColumn correlationWith: secondColumn using: aCorrelationCoefficient.
			
			correlationMatrix at: i at: j put: correlation.
			correlationMatrix at: j at: i put: correlation ] ].
	
	1 to: numericalColumnNames size do: [ :i |
		correlationMatrix at: i at: i put: 1 ].
		
	^ correlationMatrix
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
	| row |
	
	1 to: self numberOfRows do: [ :i |
		row := self rowAt: i.
		aBlock value: row. 
		"A hack to allow modification of rows inside do block"
		self rowAt: i put: row asArray ].
]

{ #category : #'find-select' }
DataFrame >> findAll: anObject atColumn: columnName [
	"Returns rowNames of rows having anObject at columnName"

	^ self rowNames select: [ :row | ((self column: columnName) at: row) = anObject ]
]

{ #category : #'find-select' }
DataFrame >> findAllIndicesOf: anObject atColumn: columnName [
	"Returns indices of rows having anObject at columnName"
	| output |
	output := OrderedCollection new.
	self rowNames withIndexDo: [ :row :index | ((self column: columnName) at: row) = anObject ifTrue: [ output add: index ]].
	^ output
]

{ #category : #statistics }
DataFrame >> firstQuartile [

	^ self applyToAllColumns: #firstQuartile
]

{ #category : #private }
DataFrame >> getJointColumnsWith: aDataFrame [
	"comment stating purpose of message"

	| columnIntersection outputColumns |
	columnIntersection := (self columnNames intersection: (aDataFrame columnNames)) asSet.
	outputColumns := OrderedCollection new.
	self columnNames do: [ :column |
		(columnIntersection includes: column)
			ifTrue: [ outputColumns add: ('' join: {column, '_x'}) ]
			ifFalse: [ outputColumns add: column ]
			].
	aDataFrame columnNames do: [ :column |
		(columnIntersection includes: column)
			ifTrue: [ outputColumns add: ('' join: {column, '_y'}) ]
			ifFalse: [ outputColumns add: column ]
			].
	
	^ outputColumns
]

{ #category : #grouping }
DataFrame >> group: anAggregateColumnName by: aGroupColumnName aggregateUsing: aBlock [
	^ self group: anAggregateColumnName by: aGroupColumnName aggregateUsing: aBlock as: anAggregateColumnName.
]

{ #category : #grouping }
DataFrame >> group: anAggregateColumnName by: aGroupColumnName aggregateUsing: aBlock as: aNewColumnName [

	| groupColumn aggregateColumn |
	
	aGroupColumnName = anAggregateColumnName
		ifTrue: [ Error signal: 'Can not group a column by itself' ].
		
	groupColumn := self column: aGroupColumnName.
	aggregateColumn := self column: anAggregateColumnName.
	
	^ aggregateColumn groupBy: groupColumn aggregateUsing: aBlock as: aNewColumnName
]

{ #category : #grouping }
DataFrame >> groupBy: columnName aggregate: anArrayOfUsingAsStatements [

	| aggregatedColumns |
	
	aggregatedColumns := anArrayOfUsingAsStatements collect: [ :aBlock |
		aBlock value: self value: columnName ].
	
	^ DataFrame
		withColumns: aggregatedColumns
		rowNames: aggregatedColumns first keys
		columnNames: (aggregatedColumns collect: #name)
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

{ #category : #accessing }
DataFrame >> indexOfColumnNamed: columnName [
	"Answer the index of a column with a given name or signal an exception if the column with that name was not found"
	^ self
		indexOfColumnNamed: columnName
		ifAbsent: [ LibrarySymbolNotFoundError signal: ('Column ', columnName, ' was not found') ].
]

{ #category : #accessing }
DataFrame >> indexOfColumnNamed: columnName ifAbsent: exceptionBlock [
	"Answer the index of a column with a given name or evaluate the exceptionBlock if the column with that name was not found"
	^ self columnNames
		indexOf: columnName
		ifAbsent: exceptionBlock.
]

{ #category : #accessing }
DataFrame >> indexOfRowNamed: rowName [
	"Answer the index of a row with a given name or signal an exception if the row with that name was not found"
	^ self
		indexOfRowNamed: rowName
		ifAbsent: [ LibrarySymbolNotFoundError signal: ('Row ', rowName, ' was not found') ].
]

{ #category : #accessing }
DataFrame >> indexOfRowNamed: rowName ifAbsent: exceptionBlock [
	"Answer the index of a row with a given name or evaluate the exceptionBlock if the row with that name was not found"
	^ self rowNames
		indexOf: rowName
		ifAbsent: exceptionBlock.
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

{ #category : #enumerating }
DataFrame >> inject: thisValue into: binaryBlock [ 
	| series |
	series := super inject: thisValue into: binaryBlock.
	series name: series defaultName.
	^ series
]

{ #category : #splitjoin }
DataFrame >> innerJoin: aDataFrame [
	"Performs inner join on aDataFrame with rowNames as keys"

	| outputRows outputDf |
	
	outputDf := self class withColumnNames: (self getJointColumnsWith: aDataFrame).
	
	"Using select instead of intersection to preserve order"
	outputRows := self rowNames select: [ :row | aDataFrame rowNames includes: row ].
	outputRows do: [ :rowName |
		| rowToAdd |
		rowToAdd := (self row: rowName) asArray, (aDataFrame row: rowName) asArray.
		outputDf addRow: rowToAdd named: rowName.
		].
	
	^ outputDf
]

{ #category : #splitjoin }
DataFrame >> innerJoin: aDataFrame on: aColumnName [
	"Inner join of self with aDataFrame on a column that has a name aColumnName in both data frames"
	^ self innerJoin: aDataFrame onLeft: aColumnName onRight: aColumnName
]

{ #category : #splitjoin }
DataFrame >> innerJoin: aDataFrame onLeft: leftColumn onRight: rightColumn [
	"Performs inner join on aDataFrame with rowNames as keys.
	 rowNames are not preserved.
	 Duplicate column names will be appended with '_x' and '_y'."

	| outputRows outputDf |
	
	outputDf := self class withColumnNames: (self getJointColumnsWith: aDataFrame).
	
	"Skip join if any of the dataframe is zero"
	((self size isZero) | (aDataFrame size isZero)) ifFalse: [
		"Using select instead of intersection to preserve order"
		outputRows := OrderedCollection new.
		(self column: leftColumn) withIndexDo: [ :ele :index |
			((aDataFrame column: rightColumn) includes: ele) ifTrue: [ outputRows add: index ] ].
		outputRows do: [ :rowIndex |
			| rowsWithSameKey rowToAdd |
			rowsWithSameKey := aDataFrame findAllIndicesOf: (self at: rowIndex at: (self indexOfColumnNamed: leftColumn)) atColumn: rightColumn.
			rowsWithSameKey do: [ :rightRow |
				rowToAdd := (self rowAt: rowIndex) asArray, (aDataFrame rowAt: rightRow) asArray.
				outputDf addRow: rowToAdd named: (outputDf size + 1).
				].
			].
		].
	
	"Since Key is common, remove duplicate key column if it is of same name"
	(leftColumn = rightColumn) ifTrue: [
		outputDf removeColumn: (rightColumn, '_y').
		outputDf renameColumn: (leftColumn, '_x') to: leftColumn.
		].
	
	^ outputDf
]

{ #category : #statistics }
DataFrame >> interquartileRange [

	^ self applyToAllColumns: #interquartileRange
]

{ #category : #splitjoin }
DataFrame >> leftJoin: aDataFrame [
	"Performs left join on aDataFrame with rowNames as keys"

	| outputDf commonRows |
	
	outputDf := self class withColumnNames: (self getJointColumnsWith: aDataFrame).
	commonRows := self rowNames intersection: aDataFrame rowNames.
	self rowNames do: [ :rowName | 
		| rowToAdd |
		rowToAdd := (commonRows includes: rowName)
			ifTrue: [ (self row: rowName) asArray , (aDataFrame row: rowName) asArray ]
			ifFalse: [ (self row: rowName) asArray , (Array new: aDataFrame columnNames size) ].
		outputDf addRow: rowToAdd named: rowName ].
	
	^ outputDf
]

{ #category : #splitjoin }
DataFrame >> leftJoin: aDataFrame on: aColumnName [
	"Left join of self with aDataFrame on a column that has a name aColumnName in both data frames"
	^ self leftJoin: aDataFrame onLeft: aColumnName onRight: aColumnName
]

{ #category : #splitjoin }
DataFrame >> leftJoin: aDataFrame onLeft: leftColumn onRight: rightColumn [
	"Performs left join on aDataFrame with rowNames as keys.
	 rowNames are not preserved.
	 Duplicate column names will be appended with '_x' and '_y'."

	| outputDf commonRows |
	
	outputDf := self class withColumnNames: (self getJointColumnsWith: aDataFrame).
	
	commonRows := (self column: leftColumn) asArray intersection: (aDataFrame column: rightColumn) asArray.
	
	1 to: self size do: [ :rowIndex |
		| rowsWithSameKey rowToAdd |
		(commonRows includes: (self at: rowIndex at: (self indexOfColumnNamed: leftColumn)))
		ifTrue: [
			"Row present in both df - append rows and add to outputDf"
			rowsWithSameKey := aDataFrame findAllIndicesOf: (self at: rowIndex at: (self indexOfColumnNamed: leftColumn)) atColumn: rightColumn.
			rowsWithSameKey do: [ :rightRow |
				rowToAdd := (self rowAt: rowIndex) asArray, (aDataFrame rowAt: rightRow) asArray.
				outputDf addRow: rowToAdd named: (outputDf size + 1).
				].
			]
		ifFalse: [
			"Row present in left-only - append nils and add to outputDf"
			rowToAdd := (self rowAt: rowIndex) asArray, (Array new: aDataFrame columnNames size).
			outputDf addRow: rowToAdd named: (outputDf size + 1)
			].
		].
	
	"Since Key is common, remove duplicate key column if it is of same name"
	(leftColumn = rightColumn) ifTrue: [
		outputDf removeColumn: (rightColumn, '_y').
		outputDf renameColumn: (leftColumn, '_x') to: leftColumn.
		].
	
	^ outputDf
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

{ #category : #splitjoin }
DataFrame >> outerJoin: aDataFrame [
	"Performs outer join on aDataFrame with rowNames as keys"

	| outputDf commonRows |
	
	outputDf := self class withColumnNames: (self getJointColumnsWith: aDataFrame).
	commonRows := self rowNames intersection: aDataFrame rowNames.
	self rowNames do: [ :rowName | 
		| rowToAdd |
		rowToAdd := (commonRows includes: rowName)
			ifTrue: [ (self row: rowName) asArray , (aDataFrame row: rowName) asArray ]
			ifFalse: [ (self row: rowName) asArray , (Array new: aDataFrame columnNames size) ].
		outputDf addRow: rowToAdd named: rowName ].
	
	aDataFrame rowNames do: [ :rowName | 
		(commonRows includes: rowName)
			ifFalse: [ outputDf
				addRow: (Array new: self columnNames size) , (aDataFrame row: rowName) asArray
				named: rowName ] ].
	
	^ outputDf
]

{ #category : #splitjoin }
DataFrame >> outerJoin: aDataFrame on: aColumnName [
	"Outer join of self with aDataFrame on a column that has a name aColumnName in both data frames"
	^ self outerJoin: aDataFrame onLeft: aColumnName onRight: aColumnName
]

{ #category : #splitjoin }
DataFrame >> outerJoin: aDataFrame onLeft: leftColumn onRight: rightColumn [
	"Performs outer join on aDataFrame with rowNames as keys.
	 rowNames are not preserved.
	 Duplicate column names will be appended with '_x' and '_y'."

	| outputDf commonRows leftNils |
	
	outputDf := self class withColumnNames: (self getJointColumnsWith: aDataFrame).
	
	commonRows := (self column: leftColumn) asArray intersection: (aDataFrame column: rightColumn) asArray.

	1 to: self size do: [ :rowIndex |
		| rowsWithSameKey rowToAdd |
		(commonRows includes: (self at: rowIndex at: (self indexOfColumnNamed: leftColumn)))
		ifTrue: [
			"Row present in both df - append rows and add to outputDf"
			rowsWithSameKey := aDataFrame findAllIndicesOf: (self at: rowIndex at: (self indexOfColumnNamed: leftColumn)) atColumn: rightColumn.
			rowsWithSameKey do: [ :rightRow |
				rowToAdd := (self rowAt: rowIndex) asArray, (aDataFrame rowAt: rightRow) asArray.
				outputDf addRow: rowToAdd named: (outputDf size + 1).
				].
			]
		ifFalse: [
			"Row present in left-only - append nils and add to outputDf"
			rowToAdd := (self rowAt: rowIndex) asArray, (Array new: aDataFrame columnNames size).
			outputDf addRow: rowToAdd named: (outputDf size + 1)
			].
		].
	
	1 to: aDataFrame size do: [ :rowIndex |
		| rowToAdd |
		(commonRows includes: (aDataFrame at: rowIndex at: (aDataFrame indexOfColumnNamed: rightColumn)))
		ifFalse: [
			"Row present in right-only - construct row and append"
			leftNils := self columnNames collect: [ :col |
				col = rightColumn
					ifTrue: [ (aDataFrame rowAt: rowIndex) at: rightColumn ]
					ifFalse: [ nil ] ].
			rowToAdd := leftNils, (aDataFrame rowAt: rowIndex) asArray.
			outputDf addRow: rowToAdd named: (outputDf size + 1).
			].
		].
	
	"Since Key is common, remove duplicate key column if it is of same name"
	(leftColumn = rightColumn) ifTrue: [
		outputDf removeColumn: (rightColumn, '_y').
		outputDf renameColumn: (leftColumn, '_x') to: leftColumn.
		].
	
	^ outputDf
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
	(columnNumber < 1 or: [ columnNumber > self numberOfColumns ])
		ifTrue: [ SubscriptOutOfBounds signalFor: columnNumber ].

	contents removeColumnAt: columnNumber.
	columnNames := columnNames copyWithoutIndex: columnNumber.
]

{ #category : #removing }
DataFrame >> removeColumns: aCollectionOfColumnNames [
	aCollectionOfColumnNames do: [ :each |
		self removeColumn: each ].
]

{ #category : #removing }
DataFrame >> removeColumnsAt: aCollectionOfColumnIndices [
	| columnNamesToRemove |
	columnNamesToRemove := aCollectionOfColumnIndices collect: [ :i |
		columnNames at: i ].
	self removeColumns: columnNamesToRemove
]

{ #category : #removing }
DataFrame >> removeColumnsOfRowElementsSatisfing: aBlock onRow: rowNumber [

	| columnNamesCopy |
	(rowNumber < 1 or: [ rowNumber > self numberOfRows ])
		ifTrue: [ SubscriptOutOfBounds signalFor: rowNumber ].
		
	columnNamesCopy := columnNames deepCopy.
	columnNames removeAll.
	columnNamesCopy withIndexDo: [ :columnName :j |
		(aBlock value: (contents at: rowNumber at: j))
			ifFalse: [ columnNames add: columnName ]].
	contents removeColumnsOfRowElementsSatisfing: aBlock onRow: rowNumber.
	
	self numberOfColumns = 0 ifTrue: [ rowNames removeAll ].
]

{ #category : #removing }
DataFrame >> removeColumnsOfRowElementsSatisfing: aBlock onRowNamed: rowName [

	| index |
	index := self indexOfRowNamed: rowName.
	self removeColumnsOfRowElementsSatisfing: aBlock onRow: index.
]

{ #category : #removing }
DataFrame >> removeColumnsWithNilsAtRow: rowNumber [
	self removeColumnsOfRowElementsSatisfing: [ :ele | ele isNil ] onRow: rowNumber.
]

{ #category : #removing }
DataFrame >> removeColumnsWithNilsAtRowNamed: rowName [
	self removeColumnsOfRowElementsSatisfing: [ :ele | ele isNil ] onRowNamed: rowName.
]

{ #category : #removing }
DataFrame >> removeRow: rowName [

	| index |
	index := self indexOfRowNamed: rowName.
	self removeRowAt: index.
]

{ #category : #removing }
DataFrame >> removeRowAt: rowNumber [
	(rowNumber < 1 or: [ rowNumber > self numberOfRows ])
		ifTrue: [ SubscriptOutOfBounds signalFor: rowNumber ].
		
	contents removeRowAt: rowNumber.
	rowNames := rowNames copyWithoutIndex: rowNumber.
]

{ #category : #removing }
DataFrame >> removeRows: aCollectionOfRowNames [
	aCollectionOfRowNames do: [ :each |
		self removeRow: each ]
]

{ #category : #removing }
DataFrame >> removeRowsAt: aCollectionOfRowIndices [
	| rowNamesToRemove |
	rowNamesToRemove := aCollectionOfRowIndices collect: [ :i |
		rowNames at: i ].
	self removeRows: rowNamesToRemove
]

{ #category : #removing }
DataFrame >> removeRowsOfColumnElementsSatisfing: aBlock onColumn: columnNumber [
	
	| rowNamesCopy |
	(columnNumber < 1 or: [ columnNumber > self numberOfColumns ])
		ifTrue: [ SubscriptOutOfBounds signalFor: columnNumber ].

	rowNamesCopy := rowNames deepCopy.
	rowNames removeAll.
	rowNamesCopy withIndexDo: [ :rowName :i |
		(aBlock value: (contents at: i at: columnNumber))
			ifFalse: [ rowNames add: rowName ] ].
	contents removeRowsOfColumnElementsSatisfing: aBlock onColumn: columnNumber.
	
	self numberOfRows = 0 ifTrue: [ columnNames removeAll ].
]

{ #category : #removing }
DataFrame >> removeRowsOfColumnElementsSatisfing: aBlock onColumnNamed: columnName [

	| index |
	index := self indexOfColumnNamed: columnName.
	self removeRowsOfColumnElementsSatisfing: aBlock onColumn: index.
]

{ #category : #removing }
DataFrame >> removeRowsWithNilsAtColumn: columnNumber [
	self removeRowsOfColumnElementsSatisfing: [ :ele | ele isNil ] onColumn: columnNumber.
]

{ #category : #removing }
DataFrame >> removeRowsWithNilsAtColumnNamed: columnName [
	self removeRowsOfColumnElementsSatisfing: [ :ele | ele isNil ] onColumnNamed: columnName.
]

{ #category : #renaming }
DataFrame >> renameColumn: oldName to: newName [
	"Find a column with oldName and rename it to newName"
	| index |
	index := self indexOfColumnNamed: oldName.
	self columnNames at: index put: newName.
]

{ #category : #renaming }
DataFrame >> renameRow: oldName to: newName [
	"Find a row with oldName and rename it to newName"
	| index |
	index := self indexOfRowNamed: oldName.
	self rowNames at: index put: newName.
]

{ #category : #splitjoin }
DataFrame >> rightJoin: aDataFrame [
	"Performs right join on aDataFrame with rowNames as keys"

	| outputDf commonRows |
	
	outputDf := self class withColumnNames: (self getJointColumnsWith: aDataFrame).
	commonRows := self rowNames intersection: aDataFrame rowNames.
	
	aDataFrame rowNames do: [ :rowName | 
		| rowToAdd |
		rowToAdd := (commonRows includes: rowName)
			ifTrue: [ (self row: rowName) asArray , (aDataFrame row: rowName) asArray ]
			ifFalse: [ (Array new: self columnNames size) , (aDataFrame row: rowName) asArray ].
		outputDf addRow: rowToAdd named: rowName ].
	
	^ outputDf
]

{ #category : #splitjoin }
DataFrame >> rightJoin: aDataFrame on: aColumnName [
	"Right join of self with aDataFrame on a column that has a name aColumnName in both data frames"
	^ self rightJoin: aDataFrame onLeft: aColumnName onRight: aColumnName
]

{ #category : #splitjoin }
DataFrame >> rightJoin: aDataFrame onLeft: leftColumn onRight: rightColumn [
	"Performs right join on aDataFrame with rowNames as keys.
	 rowNames are not preserved.
	 Duplicate column names will be appended with '_x' and '_y'."

	| outputDf commonRows leftNils |
	
	outputDf := self class withColumnNames: (self getJointColumnsWith: aDataFrame).
	
	commonRows := (self column: leftColumn) asArray intersection: (aDataFrame column: rightColumn) asArray.
	
	1 to: aDataFrame size do: [ :rowIndex |
		| rowToAdd rowsWithSameKey |
		(commonRows includes: (aDataFrame at: rowIndex at: (aDataFrame indexOfColumnNamed: rightColumn)))
		ifTrue: [ 
			"Row present in both df - append rows and add to outputDf"
			rowsWithSameKey := self findAllIndicesOf: (aDataFrame at: rowIndex at: (aDataFrame indexOfColumnNamed: rightColumn)) atColumn: leftColumn.
			rowsWithSameKey do: [ :leftRow |
				rowToAdd := (self rowAt: leftRow) asArray, (aDataFrame rowAt: rowIndex) asArray.
				outputDf addRow: rowToAdd named: (outputDf size + 1).
				]
			]
		ifFalse: [
			"Row present in right-only - construct row and append"
			leftNils := self columnNames collect: [ :col |
				col = rightColumn
					ifTrue: [ (aDataFrame rowAt: rowIndex) at: rightColumn ]
					ifFalse: [ nil ] ].
			rowToAdd := leftNils, (aDataFrame rowAt: rowIndex) asArray.
			outputDf addRow: rowToAdd named: (outputDf size + 1).
			].
		].
	
	"Since Key is common, remove duplicate key column if it is of same name"
	(leftColumn = rightColumn) ifTrue: [
		outputDf removeColumn: (rightColumn, '_y').
		outputDf renameColumn: (leftColumn, '_x') to: leftColumn.
		].
	
	^ outputDf
]

{ #category : #accessing }
DataFrame >> row: rowName [
	"Answer the row with rowName as a DataSeries or signal an exception if a row with that name was not found"
	| index |
	index := self indexOfRowNamed: rowName.
	^ self rowAt: index
]

{ #category : #accessing }
DataFrame >> row: rowName ifAbsent: exceptionBlock [
	"Answer the row with rowName as a DataSeries or evaluate exception block if a row with that name was not found"
	| index |
	index := self
		indexOfRowNamed: rowName
		ifAbsent: [ ^ exceptionBlock value ].
		
	^ self rowAt: index
]

{ #category : #accessing }
DataFrame >> row: rowName put: anArray [
	"Replace the current values of row with rowName with anArray or signal an exception if a row with that name was not found"
	| index |
	index := self indexOfRowNamed: rowName.
	^ self rowAt: index put: anArray.
]

{ #category : #accessing }
DataFrame >> row: rowName put: anArray ifAbsent: exceptionBlock [
	"Replace the current values of row with rowName with anArray or evaluate exception block if a row with that name was not found"
	| index |
	index := self
		indexOfRowNamed: rowName
		ifAbsent: [ ^ exceptionBlock value ].
		
	^ self rowAt: index put: anArray
]

{ #category : #accessing }
DataFrame >> row: rowName transform: aBlock [
	"Evaluate aBlock on the row with rowName and replace row with the result. Signal an exception if rowName was not found"
	| row |
	row := self row: rowName.
	self row: rowName put: (aBlock value: row) asArray
]

{ #category : #accessing }
DataFrame >> row: rowName transform: aBlock ifAbsent: exceptionBlock [
	"Evaluate aBlock on the row with rowName and replace row with the result. Evaluate exceptionBlock if rowName was not found"
	| row |
	row := self row: rowName ifAbsent: [ ^ exceptionBlock value ].
	self row: rowName put: (aBlock value: row)
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
DataFrame >> rowAt: aNumber transform: aBlock [
	"Evaluate aBlock on the row at aNumber and replace that row with the result"
	| row |
	row := self rowAt: aNumber.
	self rowAt: aNumber put: (aBlock value: row) asArray
]

{ #category : #accessing }
DataFrame >> rowNames [

	^ rowNames
]

{ #category : #accessing }
DataFrame >> rowNames: anArray [
	anArray size = self numberOfRows 
		ifFalse: [ SizeMismatch signal: 'Wrong number of row names' ].
		
	anArray asSet size = anArray size
		ifFalse: [ Error signal: 'All row names must be distinct' ].
		
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
DataFrame >> rows: anArrayOfRowNames put: anArrayOfArrays [
	
	anArrayOfArrays size = anArrayOfRowNames size
		ifFalse: [ SizeMismatch signal ].	
	
	anArrayOfRowNames with: anArrayOfArrays do: [ :name :array |
		self row: name put: array ].
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
DataFrame >> rowsAt: anArrayOfNumbers put: anArrayOfArrays [
	
	anArrayOfArrays size = anArrayOfNumbers size
		ifFalse: [ SizeMismatch signal ].	
	
	anArrayOfNumbers with: anArrayOfArrays do: [ :index :array |
		self rowAt: index put: array ].
]

{ #category : #accessing }
DataFrame >> rowsFrom: begin to: end [

	^ self rowsAt: (begin to: end).
]

{ #category : #accessing }
DataFrame >> rowsFrom: firstNumber to: secondNumber put: anArrayOfArrays [

	| interval |
	
	anArrayOfArrays size = ((firstNumber - secondNumber) abs + 1)
		ifFalse: [ SizeMismatch signal ].	
			
	interval := secondNumber >= firstNumber
		ifTrue: [ (firstNumber to: secondNumber) ]
		ifFalse: [ (secondNumber to: firstNumber) reversed ].
	
	interval withIndexDo: [ :rowIndex :i |
		self rowAt: rowIndex put: (anArrayOfArrays at: i) ].
]

{ #category : #enumerating }
DataFrame >> select: aBlock [ 
	"Evaluate aBlock with each of the receiver's elements as the argument. 
	Collect into a new collection like the receiver, only those elements for 
	which aBlock evaluates to true. Answer the new collection."

	| rows selectedRows selectedRowNames selectedColumnNames selectedRowsAsArrays df |
	
	rows := self asArrayOfRows.
	selectedRows := rows select: aBlock.
	selectedRowNames := (selectedRows isEmpty)
		ifTrue: [ #() ] ifFalse: [ selectedRows collect: #name ].
	selectedColumnNames := (selectedRows isEmpty)
		ifTrue: [ #() ] ifFalse: [ self columnNames ].
	selectedRowsAsArrays := selectedRows collect: #asArray.
	
	df := self class
		withRows: selectedRowsAsArrays
		rowNames: selectedRowNames
		columnNames: selectedColumnNames.
	
	^ df
]

{ #category : #private }
DataFrame >> setDefaultRowColumnNames [

	self rowNames: (1 to: self numberOfRows).
	self columnNames: (1 to: self numberOfColumns).
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

{ #category : #accessing }
DataFrame >> size [
	^ self numberOfRows
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
	column sort: aBlock.
	sortedKeys := column keys.
	
	newContents := DataFrameInternal new: self dimensions.
	
	sortedKeys withIndexDo: [ :key :i |
		newContents rowAt: i put: (self row: key) asArray ].
		
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
	| column |
	column := (self column: columnName) asArray.
	column := column collect: [ :each | aBlock value: each ].
	self column: columnName put: column asArray.
]

{ #category : #applying }
DataFrame >> toColumnAt: columnNumber applyElementwise: aBlock [
	| columnName |
	columnName := self columnNames at: columnNumber.
	^ self toColumn: columnName applyElementwise: aBlock.
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
DataFrame >> withIndexCollect: elementAndIndexBlock [
	"Overrides withIndexCollect: to create DataFrame with the same number of columns as values in the first row"
	| firstRow newDataFrame |
	
	firstRow := (self rowAt: 1) copy.
	newDataFrame := self class new: 0@(elementAndIndexBlock value: firstRow value: 1) size.
	newDataFrame columnNames: firstRow keys.
	
	self withIndexDo: [ :each :index | newDataFrame add: (elementAndIndexBlock value: each copy value: index)].
	^ newDataFrame
]

{ #category : #enumerating }
DataFrame >> withIndexDo: elementAndIndexBlock [

	1 to: self size do: [ :i |
		| row |
		row := (self rowAt: i).
		elementAndIndexBlock value: row value: i.
			
		"A hack to allow modification of rows inside do block"
		self rowAt: i put: row asArray ].
]

{ #category : #enumerating }
DataFrame >> withIndexReject: elementAndIndexBlock [ 
	"Evaluate aBlock with each of the receiver's elements and index as the arguments. 
	Collect into a new collection like the receiver, only those elements for 
	which aBlock evaluates to false. Answer the new collection."
	^ self withIndexSelect: [ :row :index | (elementAndIndexBlock value: row value: index) not ]
]

{ #category : #enumerating }
DataFrame >> withIndexSelect: elementAndIndexBlock [ 
	"Evaluate aBlock with each of the receiver's elements and index as the arguments. 
	Collect into a new collection like the receiver, only those elements for 
	which aBlock evaluates to true. Answer the new collection."

	| rows selectedRowIndices selectedRowNames selectedRowsAsArrays df |
	
	rows := self asArrayOfRows.
	selectedRowIndices := (1 to: rows size) select: [ :i |
		elementAndIndexBlock value: (rows at: i) value: i ].
	selectedRowNames := selectedRowIndices collect: [ :i | self rowNames at: i ].
	selectedRowsAsArrays := selectedRowIndices collect: [ :i | (rows at: i) asArray ].
	
	df := self class
		withRows: selectedRowsAsArrays
		rowNames: selectedRowNames
		columnNames: self columnNames.
	
	^ df
]
