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
		'columnNames',
		'dataTypes'
	],
	#category : #'DataFrame-Core'
}

{ #category : #'instance creation' }
DataFrame class >> new: aPoint [

	^ super new initialize: aPoint
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
DataFrame class >> withColumnNames: anArrayOfColumnNames withRowNames: anArrayOfRowNames [
	"Create an empty data frame with given column and row names"

	| numberOfColumns numberOfRows df |

	numberOfColumns := anArrayOfColumnNames size.
	numberOfRows := anArrayOfRowNames size.
	df := self new: numberOfRows @ numberOfColumns.

	df columnNames: anArrayOfColumnNames.
	df rowNames: anArrayOfRowNames.
	^ df
]

{ #category : #'instance creation' }
DataFrame class >> withColumns: anArrayOfArrays [

	^ self new initializeColumns: anArrayOfArrays
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
		columnNames: columns
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

	^ self new initializeRows: anArrayOfArrays
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
DataFrame >> , aDataFrame [

	| dataFrame rows |
	self columnNames = aDataFrame columnNames ifFalse: [ self error: 'Not yet supported.' ].
	(self rowNames includesAny: aDataFrame rowNames) ifTrue: [ self error: 'Not yet supported.' ].

	dataFrame := self copy.
	rows := aDataFrame asArrayOfRows.
	aDataFrame rowNames doWithIndex: [ :name :index | dataFrame addRow: (rows at: index) named: name ].

	^ dataFrame
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

	^ aDataFrame contents = self contents
]

{ #category : #adding }
DataFrame >> add: aDataSeries [

	"Add DataSeries as a new row at the end"

	self flag:
		'This mathod name is not correct. It is misleading. We should think if we should delete it or keep it'.
	self addRow: aDataSeries
]

{ #category : #adding }
DataFrame >> addColumn: aDataSeries [
	"Add DataSeries as a new column at the end"
	self addColumn: aDataSeries named: aDataSeries name.
	(self dataTypes ) at: aDataSeries name put: aDataSeries calculateDataType
]

{ #category : #adding }
DataFrame >> addColumn: aDataSeries atPosition: aNumber [
	"Add DataSeries as a new column at the given position"
	self addColumn: aDataSeries asArray named: aDataSeries name atPosition: aNumber
]

{ #category : #adding }
DataFrame >> addColumn: anArray named: aString [
	"Add a new column at the end"
	self addColumn: anArray named: aString atPosition: self numberOfColumns + 1
]

{ #category : #adding }
DataFrame >> addColumn: anArray named: aString atPosition: aNumber [
	"Add a new column at the given position"
	(self columnNames includes: aString)
		ifTrue: [ Error signal: 'A column with that name already exists' ].

	contents addColumn: anArray asArray atPosition: aNumber.
	columnNames add: aString afterIndex: aNumber - 1.
	dataTypes at: aString put: (anArray asDataSeries calculateDataType)
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
	self addRow: aDataSeries asArray named: aDataSeries name
]

{ #category : #adding }
DataFrame >> addRow: aDataSeries atPosition: aNumber [
	"Add DataSeries as a new row at the given position"
	self addRow: aDataSeries named: aDataSeries name atPosition: aNumber
]

{ #category : #adding }
DataFrame >> addRow: anArray named: aString [
	"Add a new row at the end"
	self addRow: anArray named: aString atPosition: self numberOfRows + 1
]

{ #category : #adding }
DataFrame >> addRow: anArray named: aString atPosition: aNumber [
	"Add a new row at the given position"
	(self rowNames includes: aString)
		ifTrue: [ Error signal: 'A row with that name already exists' ].

	contents addRow: anArray atPosition: aNumber.
	rowNames add: aString afterIndex: aNumber - 1
]

{ #category : #applying }
DataFrame >> applyElementwise: aBlock [
	"Applies a given block to all columns of a data frame"

	self toColumns: self columnNames applyElementwise: aBlock
]

{ #category : #enumerating }
DataFrame >> applySize [
	"Answer a new instance of the receiver with the size of each element at each element position"

	^ self collectWithIndex: [ :r :i |
		DataSeries
			withValues: (r values collect: [ : e | e ifNil: [ 0 ] ifNotNil: [ e size ]])
			name: i ]
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
DataFrame >> asArray [

	"Converts DataFrame to the array of rows"

	^ self asArrayOfRows
]

{ #category : #converting }
DataFrame >> asArrayOfColumns [
	"Converts DataFrame to the array of columns"

	^ contents asArrayOfColumns.
]

{ #category : #converting }
DataFrame >> asArrayOfRows [
	"Converts DataFrame to the array of rows"

	^ contents asArrayOfRows
]

{ #category : #converting }
DataFrame >> asArrayOfRowsWithName [
	"Answer an OrderedCollection where each item is an Array with:
	- the name of that row, in first place,
	- the contents of that row.
	"

	^ self rowNames withIndexCollect: [ :name :index |
		Array streamContents: [ :stream |
			stream nextPut: name;
				nextPutAll: (self at: index) ] ]
]

{ #category : #accessing }
DataFrame >> at: aNumber [
	"Returns the row of a DataFrame at row index aNumber"
	
	^ self rowAt: aNumber
]

{ #category : #accessing }
DataFrame >> at: rowNumber at: columnNumber [
	"Returns the value whose row index is rowNumber and column index is columnNumber"
	
	^ contents at: rowNumber at: columnNumber
]

{ #category : #accessing }
DataFrame >> at: rowNumber at: columnNumber put: value [
	"Replaces the original value of a DataFrame at row index rowNumber and column index columnNumber with a given value"
	
	contents at: rowNumber at: columnNumber put: value
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

{ #category : #accessing }
DataFrame >> atAll: indexes [
	"For polymorphisme with other collections."

	^ self rowsAt: indexes
]

{ #category : #statistics }
DataFrame >> average [
	"Average is the ratio of sum of values in a set to the number of values in the set"
	
	^ self applyToAllColumns: #average
]

{ #category : #'data-types' }
DataFrame >> calculateDataTypes [

	self asArrayOfColumns doWithIndex: [ :column :i | self dataTypes at: (self columnNames at: i) put: column calculateDataType ]
]

{ #category : #comparing }
DataFrame >> closeTo: aDataFrame [

	aDataFrame species = self species ifFalse: [ ^ false ].

	aDataFrame dimensions = self dimensions ifFalse: [ ^ false ].

	(aDataFrame rowNames = self rowNames and: [ aDataFrame columnNames = self columnNames ]) ifFalse: [ ^ false ].

	1 to: self numberOfRows do: [ :i |
		1 to: self numberOfColumns do: [ :j |
			| value |
			value := self at: i at: j.
			(value isNumber
				 ifTrue: [ value closeTo: (aDataFrame at: i at: j) ]
				 ifFalse: [ value = (aDataFrame at: i at: j) ]) ifFalse: [ ^ false ] ] ].

	^ true
]

{ #category : #comparing }
DataFrame >> closeTo: aDataFrame precision: epsilon [

	aDataFrame species = self species ifFalse: [ ^ false ].

	aDataFrame dimensions = self dimensions ifFalse: [ ^ false ].

	(aDataFrame rowNames = self rowNames and: [ aDataFrame columnNames = self columnNames ]) ifFalse: [ ^ false ].

	1 to: self numberOfRows do: [ :i |
		1 to: self numberOfColumns do: [ :j |
			| value |
			value := self at: i at: j.
			(value isNumber
				 ifTrue: [ value closeTo: (aDataFrame at: i at: j) precision: epsilon ]
				 ifFalse: [ value = (aDataFrame at: i at: j) ]) ifFalse: [ ^ false ] ] ].

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

{ #category : #enumerating }
DataFrame >> collectWithIndex: aBlock [
	"Overrides the Collection>>collect to create DataFrame with the same number of columns as values in the first row"
	| firstRow newDataFrame |

	firstRow := aBlock value: (self rowAt: 1) copy value: 1.
	newDataFrame := self class new: 0@firstRow size.
	newDataFrame columnNames: firstRow keys.

	self doWithIndex: [ : each : index | newDataFrame add: (aBlock value: each copy value: index) ].
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
	^ self columnAt: index put: anArray
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
	"Returns the column of a DataFrame at column index aNumber"
	
	^ (DataSeries withKeys: self rowNames values: (contents columnAt: aNumber))
		  name: (self columnNames at: aNumber);
		  yourself
]

{ #category : #accessing }
DataFrame >> columnAt: aNumber put: anArray [
	"Replaces the column at column index aNumber with contents of the array anArray"
	
	anArray size = self numberOfRows
		ifFalse: [ SizeMismatch signal ].

	contents columnAt: aNumber put: anArray
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
	"Returns the column names of a DataFrame"
	
	^ columnNames
]

{ #category : #accessing }
DataFrame >> columnNames: aCollection [
	"Sets the column names of a DataFrame with contents of the collection aCollection"
	
	| type |
	aCollection size = self numberOfColumns
		ifFalse: [ SizeMismatch signal: 'Wrong number of column names' ].

	aCollection asSet size = aCollection size
		ifFalse: [ Error signal: 'All column names must be distinct' ].

	self columnNames ifNotNil: [
		self columnNames withIndexDo: [ :currentColumnName :i |
			type := dataTypes at: currentColumnName.
			dataTypes removeKey: currentColumnName.
			dataTypes at: (aCollection at: i) put: type ] ].

	columnNames := aCollection asOrderedCollection
]

{ #category : #accessing }
DataFrame >> columns [
	"Returns a collection of all columns"

	^ (1 to: self numberOfColumns) collect: [ :j | self columnAt: j ]
]

{ #category : #accessing }
DataFrame >> columns: anArrayOfNames [
	"Returns a collection of columns whose column names are present in the array anArrayOfNames"
	
	| anArrayOfNumbers |

	anArrayOfNumbers := anArrayOfNames
		collect: [ :name |
			self indexOfColumnNamed: name ].

	^ self columnsAt: anArrayOfNumbers
]

{ #category : #accessing }
DataFrame >> columns: anArrayOfColumnNames put: anArrayOfArrays [
	"Replaces the columns whose column names are present in the array anArrayOfColumnNames with the contents of the array of arrays anArrayOfArrays"

	anArrayOfArrays size = anArrayOfColumnNames size
		ifFalse: [ SizeMismatch signal ].

	anArrayOfColumnNames with: anArrayOfArrays do: [ :name :array |
		self column: name put: array ]
]

{ #category : #accessing }
DataFrame >> columnsAt: anArrayOfNumbers [
	"Returns a collection of columns whose column indices are present in the array anArrayOfNumbers"

	| newColumnNames |

	newColumnNames := (anArrayOfNumbers collect: [ :i |
		self columnNames at: i ]).

	^ DataFrame
		withDataFrameInternal: (self contents columnsAt: anArrayOfNumbers)
		rowNames: self rowNames
		columnNames: newColumnNames
]

{ #category : #accessing }
DataFrame >> columnsAt: anArrayOfNumbers put: anArrayOfArrays [
	"Replaces the columns whose column indices are present in the array anArrayOfNumbers with the contents of the array of arrays anArrayOfArrays"

	anArrayOfArrays size = anArrayOfNumbers size
		ifFalse: [ SizeMismatch signal ].

	anArrayOfNumbers with: anArrayOfArrays do: [ :index :array |
		self columnAt: index put: array ]
]

{ #category : #accessing }
DataFrame >> columnsFrom: begin to: end [
	"Returns a collection of columns whose column indices are present between begin and end"

	| array |

	array := begin < end
		ifTrue: [ (begin to: end) asArray ]
		ifFalse: [ (end to: begin) asArray reverse ].

	^ self columnsAt: array
]

{ #category : #accessing }
DataFrame >> columnsFrom: firstNumber to: secondNumber put: anArrayOfArrays [
	"Replaces the columns whose column indices are present between firstNumber and secondNumber with the contents of the array of arrays anArrayOfArrays"

	| interval |

	anArrayOfArrays size = ((firstNumber - secondNumber) abs + 1)
		ifFalse: [ SizeMismatch signal ].

	interval := secondNumber >= firstNumber
		ifTrue: [ (firstNumber to: secondNumber) ]
		ifFalse: [ (secondNumber to: firstNumber) reversed ].

	interval withIndexDo: [ :columnIndex :i |
		self columnAt: columnIndex put: (anArrayOfArrays at: i) ]
]

{ #category : #accessing }
DataFrame >> contents [
	"Returns all the values of the DataFrame"
	
	^ contents
]

{ #category : #copying }
DataFrame >> copyReplace: missingValue in2DCollectionBy: arrayOfReplacementValues [
	"I am a 2D collection and the goal is to return a copy replace the missing values by the values of my second parameter. The good value is the index of the missing value in the sub collection.

	I am needed for the project pharo-ai/data-imputers. I can work without that method but the time it will take to replace the missing values will be huuuuuuuuuuuge"

	| copy |
	copy := self copy.
	1 to: self numberOfColumns do: [ :columnIndex |
		| replacementValue |
		replacementValue := arrayOfReplacementValues at: columnIndex.
		1 to: self numberOfRows do: [ :rowIndex | (self at: rowIndex at: columnIndex) = missingValue ifTrue: [ self copy at: rowIndex at: columnIndex put: replacementValue ] ] ].
	^ copy
]

{ #category : #statistics }
DataFrame >> correlationMatrix [
	"Calculate a correlation matrix (correlation of every column with every column) using Pearson's correlation coefficient"
	^ self correlationMatrixUsing: DataPearsonCorrelationMethod
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
	"Returns the cross tabulation of a column named colName1 with the column named colName2 of the DataFrame"

	| col1 col2 |

	col1 := self column: colName1.
	col2 := self column: colName2.

	^ col1 crossTabulateWith: col2
]

{ #category : #copying }
DataFrame >> dataPreProcessingEncodeWith: anEncoder [
	"This method is here to speed up pharo-ai/data-preprocessing algos without coupling both projects."

	| copy cache |
	copy := self copy.
	cache := IdentityDictionary new.
	self columns doWithIndex: [ :dataSerie :columnIndex |
		| category |
		category := cache at: columnIndex ifAbsentPut: [ ((anEncoder categories at: columnIndex) collectWithIndex: [ :elem :index | elem -> index ]) asDictionary ].
		dataSerie doWithIndex: [ :element :rowIndex |
			copy at: rowIndex at: columnIndex put: (category at: element ifAbsent: [ AIMissingCategory signalFor: element ]) ] ].

	^ copy
]

{ #category : #'data-types' }
DataFrame >> dataTypeOfColumn: aColumnName [
	"Given a column name of the DataFrame, it returns the data type of that column"
	
	^ dataTypes at: aColumnName
]

{ #category : #'data-types' }
DataFrame >> dataTypeOfColumn: aColumnName put: aDataType [
	"Given a column name and a data type, it replaces the original data type of that column with the data type that was given as a parameter"

	dataTypes at: aColumnName put: aDataType
]

{ #category : #'data-types' }
DataFrame >> dataTypeOfColumnAt: aNumber [
	"Given a column index of the DataFrame, it returns the data type of that column"

	^ self dataTypeOfColumn: (columnNames at: aNumber)
]

{ #category : #'data-types' }
DataFrame >> dataTypeOfColumnAt: aNumber put: aDataType [
	"Given a column index and a data type, it replaces the original data type of that column with the data type that was given as a parameter"

	^ self dataTypeOfColumn: (columnNames at: aNumber) put: aDataType
]

{ #category : #accessing }
DataFrame >> dataTypes [
	"Returns the data types of each column"
	
	^ dataTypes
]

{ #category : #accessing }
DataFrame >> dataTypes: anObject [

	dataTypes := anObject
]

{ #category : #accessing }
DataFrame >> defaultHeadTailSize [

	^ 5
]

{ #category : #statistics }
DataFrame >> describe [
	"Answer another data frame with statistics describing the columns of this data frame"

	| content |
	content := self numericalColumns collect: [ :column |
		           {
			           column countNonNils.
			           column average.
			           column stdev.
			           column min.
			           column firstQuartile.
			           column secondQuartile.
			           column thirdQuartile.
			           column max.
			           column calculateDataType } ].

	^ self class
		  withRows: content
		  rowNames: self numericalColumnNames
		  columnNames: #( count mean std min '25%' '50%' '75%' max dtype )
]

{ #category : #accessing }
DataFrame >> dimensions [
	"Returns the number of rows and number of columns in a DataFrame"
	
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
		self rowAt: i put: row asArray ]
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

{ #category : #accessing }
DataFrame >> first [
	"Returns the first row of the DataFrame"
	
	^ self at: 1
]

{ #category : #statistics }
DataFrame >> firstQuartile [
    "25% of the values in a set are smaller than or equal to the first Quartile of that set"

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
	"Group the values of the cloumn named anAggregateColumnName by the unique values of the column named aGroupColumnName, aggregate them using aBlock. With the same name as anAggregateColumnName"
	
	^ self group: anAggregateColumnName by: aGroupColumnName aggregateUsing: aBlock as: anAggregateColumnName
]

{ #category : #grouping }
DataFrame >> group: anAggregateColumnName by: aGroupColumnName aggregateUsing: aBlock as: aNewColumnName [
	"Group the values of the cloumn named anAggregateColumnName by the unique values of the column named aGroupColumnName, aggregate them using aBlock. With a new column name aNewColumnName"

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

{ #category : #replacing }
DataFrame >> hasNils [
	"Returns true if there is atleast one nil value in the data frame. Returns false if there are no nil values in the dataframe"

	| arrayOfColumns |
	arrayOfColumns := self asArrayOfColumns.
	1 to: self numberOfColumns do: [ :column |
		1 to: self numberOfRows do: [ :row |
		((arrayOfColumns at: column) at: row) ifNil: [ ^ true ] ] ].
	^ false
]

{ #category : #replacing }
DataFrame >> hasNilsByColumn [

	"Returns a dictionary which indicates the presence of any nil values column wise"

	| dictionary |
	dictionary := Dictionary new.
	self columnNames do: [ :each |
		dictionary at: each put: (self column: each) hasNil ].
	^ dictionary
]

{ #category : #accessing }
DataFrame >> head [
	"Returns the first 5 rows of the DataFrame"
	
	^ self head: self defaultHeadTailSize
]

{ #category : #accessing }
DataFrame >> head: aNumber [
	"Returns the first aNumber rows of a DataFrame"
	
	^ self rowsAt: (1 to: (self numberOfRows min: aNumber))
]

{ #category : #accessing }
DataFrame >> indexOfColumnNamed: columnName [
	"Answer the index of a column with a given name or signal an exception if the column with that name was not found"
	^ self
		indexOfColumnNamed: columnName
		ifAbsent: [ self error: ('Column ', columnName, ' was not found') ]
]

{ #category : #accessing }
DataFrame >> indexOfColumnNamed: columnName ifAbsent: exceptionBlock [
	"Answer the index of a column with a given name or evaluate the exceptionBlock if the column with that name was not found"
	^ self columnNames
		indexOf: columnName
		ifAbsent: exceptionBlock
]

{ #category : #accessing }
DataFrame >> indexOfRowNamed: rowName [
	"Answer the index of a row with a given name or signal an exception if the row with that name was not found"
	^ self
		indexOfRowNamed: rowName
		ifAbsent: [ self error: ('Row ', rowName, ' was not found') ]
]

{ #category : #accessing }
DataFrame >> indexOfRowNamed: rowName ifAbsent: exceptionBlock [
	"Answer the index of a row with a given name or evaluate the exceptionBlock if the row with that name was not found"
	^ self rowNames
		indexOf: rowName
		ifAbsent: exceptionBlock
]

{ #category : #printing }
DataFrame >> info [
	"Prints the number of entries and number of columns of a data frame. For each column of the data frame, it prints the column index, column name, number of non-nil values in the column and the data type of the contents of the column"
	
	^ String streamContents: [ :aStream |
		  aStream
			  nextPutAll: 'DataFrame: ';
			  print: self size;
			  nextPutAll: ' entries';
			  cr;
			  nextPutAll: 'Data columns (total ';
			  print: self columnNames size;
			  nextPutAll: ' columns):';
			  cr;
			  nextPutAll: ' # | Column | Non-nil count | Dtype';
			  cr;
			  nextPutAll: '---------------------------------------------------';
			  cr.
		  self columnNames doWithIndex: [ :col :index |
			  aStream
				  print: index;
				  nextPutAll: ' | '.
			  col isString
				  ifTrue: [ aStream nextPutAll: col ]
				  ifFalse: [ aStream print: col ].
			  aStream
				  nextPutAll: ' | ';
				  print: ((self columnAt: index) reject: #isNil) size;
				  nextPutAll: ' non-nil | ';
				  print: (self dataTypes at: col);
				  cr ] ]
]

{ #category : #initialization }
DataFrame >> initialize [

	super initialize.

	dataTypes := Dictionary new.
	contents := DataFrameInternal new.
	self setDefaultRowColumnNames.
	self calculateDataTypes
]

{ #category : #initialization }
DataFrame >> initialize: aPoint [

	super initialize.

	contents := DataFrameInternal new: aPoint.
	self setDefaultRowColumnNames.
	self calculateDataTypes
]

{ #category : #initialization }
DataFrame >> initializeColumns: anArrayOfArrays [

	contents := DataFrameInternal withColumns: anArrayOfArrays.
	self setDefaultRowColumnNames.
	self calculateDataTypes
]

{ #category : #initialization }
DataFrame >> initializeContents: aDataFrameInternal rowNames: rows columnNames: columns [

	super initialize.

	contents := aDataFrameInternal.
	self rowNames: rows.
	self columnNames: columns.
	self calculateDataTypes
]

{ #category : #initialization }
DataFrame >> initializeRows: anArrayOfArrays [

	contents := DataFrameInternal withRows: anArrayOfArrays.
	self setDefaultRowColumnNames.
	self calculateDataTypes
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

{ #category : #newtools }
DataFrame >> inspectionItems: aBuilder [
	<inspectorPresentationOrder: 0 title: 'DataFrame'>

	| table |
	table := aBuilder newTable.

	table addColumn: (SpIndexTableColumn new
		title: '#';
		sortFunction: #yourself ascending;
		beNotExpandable;
		yourself).

	(self columnNames) doWithIndex: [ :headerName :columnIndex |
		table addColumn: (SpStringTableColumn
			title: headerName
			evaluated: [ :rowWithName | rowWithName at: columnIndex + 1 ]) ].

	table items: self asArrayOfRowsWithName.

	^ table
]

{ #category : #statistics }
DataFrame >> interquartileRange [
	"The Inter Quartile Range is the difference between the third Quartile and the first Quartile"

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
	"Max is the largest value present in a set of values"
	
	^ self applyToAllColumns: #max
]

{ #category : #statistics }
DataFrame >> median [
   "50% of data points have a value smaller or equal to the median . The median of a set of values is the middle value of the set when the set is arranged in increasing order."

	^ self applyToAllColumns: #median
]

{ #category : #statistics }
DataFrame >> min [
	"Min is the smallest value present in a set of values"

	^ self applyToAllColumns: #min
]

{ #category : #statistics }
DataFrame >> mode [
	"The mode of a set of values is the value that appears most often. "

	^ self applyToAllColumns: #mode
]

{ #category : #converting }
DataFrame >> normalized [
	"This methods returns a new DataFrame, without altering this one, that has all the columns normalized."

	| normalizers normalizedColumns |
	self deprecated:
		'DataFrame will remove the dependency over normalization in the next version. You can use pharo-ai/data-preprocessing project to normalize your DataFrame and even more!'.
	normalizers := (1 to: self anyOne size) collect: [ :e | self class defaultNormalizerClass new ].

	normalizedColumns := self asArrayOfColumns with: normalizers collect: [ :col :normalizer | col normalizedUsing: normalizer ].

	^ self class withColumns: normalizedColumns columnNames: self columnNames
]

{ #category : #accessing }
DataFrame >> numberOfColumns [
	"Returns the number of columns of a DataFrame"
	
	^ contents numberOfColumns
]

{ #category : #replacing }
DataFrame >> numberOfNils [
	"Returns a dictionary which indicates the number of nil values column wise"

	| dictionary count |
	dictionary := Dictionary new.
	self columnNames do: [ :each |
		count := (self column: each) count: [ :each2 | each2 isNil ].
		dictionary at: each put: count ].
	^ dictionary
]

{ #category : #accessing }
DataFrame >> numberOfRows [
	"Returns the number of rows of a DataFrame"

	^ contents numberOfRows
]

{ #category : #accessing }
DataFrame >> numericalColumnNames [
	"Returns the names of all numerical columns of the dataframe"

	^ self columnNames select: [ :columnName |
		  (self dataTypes at: columnName) includesBehavior: Number ]
]

{ #category : #accessing }
DataFrame >> numericalColumns [
	"Returns all numerical columns of the dataframe"

	^ self columns select: [ :column |
		  (self dataTypes at: column name) includesBehavior: Number ]
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

{ #category : #copying }
DataFrame >> postCopy [

	super postCopy.
	contents := contents copy.
	rowNames := rowNames copy.
	columnNames := columnNames copy.
	dataTypes := dataTypes copy
]

{ #category : #printing }
DataFrame >> printOn: aStream [

	| title |
	title := self class name.
	aStream
		nextPutAll: (title first isVowel ifTrue: ['an '] ifFalse: ['a ']);
		nextPutAll: title;
		space;
		nextPutAll: self dimensions asString
]

{ #category : #private }
DataFrame >> privateRowNames: anArray [
	"I am a private method skipping the assertions when my internal mecanisms know they can skip them."

	rowNames := anArray asOrderedCollection
]

{ #category : #statistics }
DataFrame >> range [
	"Range is the difference between the highest value and the lowest value in a set"

	^ self applyToAllColumns: #range
]

{ #category : #removing }
DataFrame >> removeColumn: columnName [
	"Removes the column named columnName from a data frame"
	
	| index |
	index := self indexOfColumnNamed: columnName.
	self removeColumnAt: index
]

{ #category : #removing }
DataFrame >> removeColumnAt: columnNumber [
	"Removes the column at column index columnNumber from a data frame"

	(columnNumber < 1 or: [ columnNumber > self numberOfColumns ])
		ifTrue: [ SubscriptOutOfBounds signalFor: columnNumber ].

	self dataTypes removeKey: (self columnAt: columnNumber) name.

	contents removeColumnAt: columnNumber.
	columnNames := columnNames copyWithoutIndex: columnNumber
]

{ #category : #removing }
DataFrame >> removeColumns: aCollectionOfColumnNames [
	"Removes all columns from a data frame whose names are present in the collection aCollectionOfColumnNames"

	aCollectionOfColumnNames do: [ :each |
		self removeColumn: each.
		]
]

{ #category : #removing }
DataFrame >> removeColumnsAt: aCollectionOfColumnIndices [
	"Removes all columns from a data frame whose column indices are present in the collection aCollectionOfColumnIndices"

	| columnNamesToRemove |
	columnNamesToRemove := aCollectionOfColumnIndices collect: [ :i |
		columnNames at: i ].
	self removeColumns: columnNamesToRemove
]

{ #category : #removing }
DataFrame >> removeColumnsOfRowElementsSatisfing: aBlock onRowNamed: rowName [
	"Removes columns from a data frame whose row elements at the row named rowName satisfy a given block"

	| index |
	index := self indexOfRowNamed: rowName.
	self removeColumnsOfRowElementsSatisfying: aBlock onRow: index
]

{ #category : #removing }
DataFrame >> removeColumnsOfRowElementsSatisfying: aBlock onRow: rowNumber [
	"Removes columns from a data frame whose row elements at the row index rowNumber satisfy a given block"

	| columnNamesCopy |
	(rowNumber < 1 or: [ rowNumber > self numberOfRows ])
		ifTrue: [ SubscriptOutOfBounds signalFor: rowNumber ].

	columnNamesCopy := columnNames deepCopy.
	columnNames removeAll.
	columnNamesCopy withIndexDo: [ :columnName :j |
		(aBlock value: (contents at: rowNumber at: j))
			ifFalse: [ columnNames add: columnName ]].
	contents removeColumnsOfRowElementsSatisfying: aBlock onRow: rowNumber.

	self numberOfColumns = 0 ifTrue: [ rowNames removeAll ]
]

{ #category : #'handling nils' }
DataFrame >> removeColumnsWithNilsAtRow: rowNumber [
	"Removes all columns with nil values at row number rowNumber from the data frame"
	
	self removeColumnsOfRowElementsSatisfying: [ :ele | ele isNil ] onRow: rowNumber
]

{ #category : #'handling nils' }
DataFrame >> removeColumnsWithNilsAtRowNamed: rowName [
	"Removes all columns with nil values at a row named rowName from the data frame"

	self removeColumnsOfRowElementsSatisfing: [ :ele | ele isNil ] onRowNamed: rowName
]

{ #category : #removing }
DataFrame >> removeDuplicatedRows [
	"Removes duplicate rows of a dataframe except the first unique row"

	| numberOfRows nextRowIndex currentRow row aSet |
	aSet := Set new.
	numberOfRows := self numberOfRows.
	1 to: numberOfRows do: [ :currentRowIndex |
		currentRow := self rowAt: currentRowIndex.
		nextRowIndex := currentRowIndex + 1.
		nextRowIndex to: numberOfRows do: [ :index |
			row := self rowAt: index.
			row values = currentRow values ifTrue: [ aSet add: index ] ] ].
	^ self removeRowsAt: aSet
]

{ #category : #removing }
DataFrame >> removeRow: rowName [
	"Removes the row named rowName from a data frame"

	| index |
	index := self indexOfRowNamed: rowName.
	self removeRowAt: index
]

{ #category : #removing }
DataFrame >> removeRowAt: rowNumber [
	"Removes the row at row index rowNumber from a data frame"

	(rowNumber < 1 or: [ rowNumber > self numberOfRows ])
		ifTrue: [ SubscriptOutOfBounds signalFor: rowNumber ].

	contents removeRowAt: rowNumber.
	rowNames := rowNames copyWithoutIndex: rowNumber
]

{ #category : #removing }
DataFrame >> removeRows: aCollectionOfRowNames [
	"Removes all rows from a data frame whose names are present in the collection aCollectionOfRowNames"

	aCollectionOfRowNames do: [ :each |
		self removeRow: each ]
]

{ #category : #removing }
DataFrame >> removeRowsAt: aCollectionOfRowIndices [
	"Removes all rows from a data frame whose row indices are present in the collection aCollectionOfRowIndices"

	| rowNamesToRemove |
	rowNamesToRemove := aCollectionOfRowIndices collect: [ :i |
		rowNames at: i ].
	self removeRows: rowNamesToRemove
]

{ #category : #removing }
DataFrame >> removeRowsOfColumnElementsSatisfing: aBlock onColumnNamed: columnName [
	"Removes rows from a data frame whose column elements at the column named columnName satisfy a given block"

	| index |
	index := self indexOfColumnNamed: columnName.
	self removeRowsOfColumnElementsSatisfying: aBlock onColumn: index
]

{ #category : #removing }
DataFrame >> removeRowsOfColumnElementsSatisfying: aBlock onColumn: columnNumber [
	"Removes rows from a data frame whose column elements at the column index columnNumber satisfy a given block"

	| rowNamesCopy |
	(columnNumber < 1 or: [ columnNumber > self numberOfColumns ])
		ifTrue: [ SubscriptOutOfBounds signalFor: columnNumber ].

	rowNamesCopy := rowNames deepCopy.
	rowNames removeAll.
	rowNamesCopy withIndexDo: [ :rowName :i |
		(aBlock value: (contents at: i at: columnNumber))
			ifFalse: [ rowNames add: rowName ] ].
	contents removeRowsOfColumnElementsSatisfying: aBlock onColumn: columnNumber.

	self numberOfRows = 0 ifTrue: [ columnNames removeAll ]
]

{ #category : #removing }
DataFrame >> removeRowsWithNils [
	"Removes all rows from a data frame which have atleast one nil value"
	
	1 to: self numberOfColumns do: [ :i |
		self
			removeRowsOfColumnElementsSatisfying: [ :ele | ele isNil ]
			onColumn: i ]
]

{ #category : #'handling nils' }
DataFrame >> removeRowsWithNilsAtColumn: columnNumber [
	"Removes all rows with nil values at column number columnNumber from the data frame"

	self removeRowsOfColumnElementsSatisfying: [ :ele | ele isNil ] onColumn: columnNumber
]

{ #category : #'handling nils' }
DataFrame >> removeRowsWithNilsAtColumnNamed: columnName [
	"Removes all rows with nil values at a column named columnName from the data frame"

	self removeRowsOfColumnElementsSatisfing: [ :ele | ele isNil ] onColumnNamed: columnName
]

{ #category : #renaming }
DataFrame >> renameColumn: oldName to: newName [
	"Find a column with oldName and rename it to newName"
	| index |
	index := self indexOfColumnNamed: oldName.
	self columnNames at: index put: newName.

	self dataTypes at: newName put: (self dataTypes at: oldName).
	self dataTypes removeKey: oldName
]

{ #category : #renaming }
DataFrame >> renameRow: oldName to: newName [
	"Find a row with oldName and rename it to newName"
	| index |
	index := self indexOfRowNamed: oldName.
	self rowNames at: index put: newName
]

{ #category : #'handling nils' }
DataFrame >> replaceAllNilsWithZeros [

	self deprecated: 'Use #replaceNilsWithZero instead.' transformWith: '`@receiver replaceAllNilsWithZeros' -> '`@receiver replaceNilsWithZero'.

	self replaceNilsWithZero
]

{ #category : #replacing }
DataFrame >> replaceNilsWith: anObject [
	"Replaces all nil values of a data frame with the object anObject"
	
	1 to: self numberOfColumns do: [ :columnIndex |
		1 to: self numberOfRows do: [ :rowIndex |
			(self at: rowIndex at: columnIndex) ifNil:
				[ self at: rowIndex at: columnIndex put: anObject ] ]
		]
]

{ #category : #replacing }
DataFrame >> replaceNilsWithAverage [
	"Replaces all nil values of a data frame with the average value of the column in which it is present"

	| averageOfColumn |
	1 to: self numberOfColumns do: [ :i |
		averageOfColumn := ((self columnAt: i) select: [ :ele | ele isNotNil ]) average.
		1 to: self numberOfRows do: [ :j |
			(self at: j at: i) ifNil: [
				self at: j at: i put: averageOfColumn  ] ].
		]
]

{ #category : #replacing }
DataFrame >> replaceNilsWithMedian [
	"Replaces all nil values of a data frame with the median of the column in which it is present"

	| medianOfColumn |
	1 to: self numberOfColumns do: [ :i |
		medianOfColumn := ((self columnAt: i) select: [ :ele | ele isNotNil ]) median.
		1 to: self numberOfRows do: [ :j |
			(self at: j at: i) ifNil: [
				self at: j at: i put: medianOfColumn  ] ].
		]
]

{ #category : #replacing }
DataFrame >> replaceNilsWithMode [
	"Replaces all nil values of a data frame with the mode of the column in which it is present"

	1 to: self numberOfColumns do: [ :i |
		| modeOfColumn |
		1 to: self numberOfRows do: [ :j |
		(self at: j at: i) ifNil: [ self at: j at: i put: (modeOfColumn ifNil: [ modeOfColumn := ((self columnAt: i) select: [ :ele | ele isNotNil ]) mode ]) ] ].
		modeOfColumn := nil ]
]

{ #category : #replacing }
DataFrame >> replaceNilsWithNextRowValue [

	| value numberOfRows |
	numberOfRows := self numberOfRows.
	1 to: self numberOfColumns do: [ :i |
		self numberOfRows to: 1 by: -1 do: [ :j |
			j < numberOfRows ifTrue: [
				(self at: j at: i) ifNil: [ self at: j at: i put: value ] ].
			value := self at: j at: i ] ]
]

{ #category : #replacing }
DataFrame >> replaceNilsWithPreviousRowValue [
	"Replaces all nil values of a data frame with the previous non-nil value of the column in which it is present"

	|value|
	1 to: self numberOfColumns do: [ :i |
		1 to: self numberOfRows do: [ :j |

			j > 1
				ifTrue: [
					(self at: j at: i) ifNil: [ self at: j at: i put: value ].
				 	].
			value:= self at: j at: i.
		].
	]
]

{ #category : #replacing }
DataFrame >> replaceNilsWithZero [
	"Replaces all nil values of a data frame with xero"

	self replaceNilsWith: 0
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
	^ self rowAt: index put: anArray
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
	"Returns the row of a DataFrame at row index aNumber"

	| series |
	series := (contents rowAt: aNumber) asDataSeries.
	series name: (self rowNames at: aNumber).
	series keys: self columnNames.
	^ series
]

{ #category : #accessing }
DataFrame >> rowAt: aNumber put: anArray [
	"Replaces the row at row index aNumber with contents of the array anArray"

	anArray size = self numberOfColumns
		ifFalse: [ SizeMismatch signal ].

	contents rowAt: aNumber put: anArray
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
	"Returns the row names of a DataFrame"
	
	^ rowNames
]

{ #category : #accessing }
DataFrame >> rowNames: anArray [
	"Sets the row names of a DataFrame with contents of the collection aCollection"

	anArray size = self numberOfRows ifFalse: [ SizeMismatch signal: 'Wrong number of row names' ].

	anArray asSet size = anArray size ifFalse: [ Error signal: 'All row names must be distinct' ].

	self privateRowNames: anArray
]

{ #category : #accessing }
DataFrame >> rows [
	"Returns a collection of all rows"

	^ (1 to: self numberOfRows) collect: [ :j | self rowAt: j ]
]

{ #category : #accessing }
DataFrame >> rows: anArrayOfNames [
	"Returns a collection of rows whose row names are present in the array anArrayOfNames"

	| anArrayOfNumbers |

	anArrayOfNumbers := anArrayOfNames
		collect: [ :name |
			self indexOfRowNamed: name ].

	^ self rowsAt: anArrayOfNumbers
]

{ #category : #accessing }
DataFrame >> rows: anArrayOfRowNames put: anArrayOfArrays [
	"Replaces the rows whose row names are present in the array anArrayOfRowNames with the contents of the array of arrays anArrayOfArrays"

	anArrayOfArrays size = anArrayOfRowNames size
		ifFalse: [ SizeMismatch signal ].

	anArrayOfRowNames with: anArrayOfArrays do: [ :name :array |
		self row: name put: array ]
]

{ #category : #accessing }
DataFrame >> rowsAt: anArrayOfNumbers [
	"Returns a collection of rows whose row indices are present in the array anArrayOfNumbers"

	| newRowNames |

	newRowNames := (anArrayOfNumbers collect: [ :i |
		self rowNames at: i ]).

	^ DataFrame
		withDataFrameInternal: (self contents rowsAt: anArrayOfNumbers)
		rowNames: newRowNames
		columnNames: self columnNames
]

{ #category : #accessing }
DataFrame >> rowsAt: anArrayOfNumbers put: anArrayOfArrays [
	"Replaces the rows whose row indices are present in the array anArrayOfNumbers with the contents of the array of arrays anArrayOfArrays"

	anArrayOfArrays size = anArrayOfNumbers size
		ifFalse: [ SizeMismatch signal ].

	anArrayOfNumbers with: anArrayOfArrays do: [ :index :array |
		self rowAt: index put: array ]
]

{ #category : #accessing }
DataFrame >> rowsFrom: begin to: end [
	"Returns a collection of rows whose row indices are present between begin and end"

	^ self rowsAt: (begin to: end)
]

{ #category : #accessing }
DataFrame >> rowsFrom: firstNumber to: secondNumber put: anArrayOfArrays [
	"Replaces the rows whose row indices are present between firstNumber and secondNumber with the contents of the array of arrays anArrayOfArrays"

	| interval |

	anArrayOfArrays size = ((firstNumber - secondNumber) abs + 1)
		ifFalse: [ SizeMismatch signal ].

	interval := secondNumber >= firstNumber
		ifTrue: [ (firstNumber to: secondNumber) ]
		ifFalse: [ (secondNumber to: firstNumber) reversed ].

	interval withIndexDo: [ :rowIndex :i |
		self rowAt: rowIndex put: (anArrayOfArrays at: i) ]
]

{ #category : #enumerating }
DataFrame >> select: aBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument.
	Collect into a new collection like the receiver, only those elements for
	which aBlock evaluates to true. Answer the new collection."

	| selectedIndexes |

	selectedIndexes := (1 to: self numberOfRows) select: [ :index |
		aBlock value: (self at: index) ].

	^ self rowsAt: selectedIndexes
]

{ #category : #private }
DataFrame >> setDefaultRowColumnNames [

	self privateRowNames: (1 to: self numberOfRows).
	self columnNames: (1 to: self numberOfColumns)
]

{ #category : #accessing }
DataFrame >> size [
	"Returns the number of rows of a DataFrame"
	
	^ self numberOfRows
]

{ #category : #sorting }
DataFrame >> sortBy: columnName [
	"Rearranges the rows of the data frame in ascending order of the values in the column named columnName"
	
	self sortBy: columnName using: [ :a :b | a <= b ]
]

{ #category : #sorting }
DataFrame >> sortBy: columnName using: aBlock [
	"Rearranges the rows of the data frame by applying the given block on the column named columnName"

	| column sortedKeys newContents |
	column := self column: columnName.
	column := column copy.
	column sort: aBlock.
	sortedKeys := column keys.

	newContents := DataFrameInternal new: self dimensions.

	sortedKeys withIndexDo: [ :key :i |
		newContents rowAt: i put: (self row: key) asArray ].

	contents := newContents.
	self rowNames: sortedKeys
]

{ #category : #sorting }
DataFrame >> sortDescendingBy: columnName [
	"Rearranges the rows of the data frame in descending order of the values in the column named columnName"

	self sortBy: columnName using: [ :a :b | a >= b ]
]

{ #category : #statistics }
DataFrame >> stdev [
   "Standard deviation is a measure of how dispersed the data is in relation to the average"

	^ self applyToAllColumns: #stdev
]

{ #category : #accessing }
DataFrame >> tail [
	"Returns the last 5 rows of a DataFrame"
	
	^ self tail: self defaultHeadTailSize
]

{ #category : #accessing }
DataFrame >> tail: aNumber [
	"Returns the last aNumber rows of aDataFrame"
	| rows |
	rows := self numberOfRows.

	^ self rowsAt: (rows - (rows min: aNumber) + 1 to: rows)
]

{ #category : #statistics }
DataFrame >> thirdQuartile [
   "75% of the values in a set are smaller than or equal to the third Quartile of that set"

	^ self applyToAllColumns: #thirdQuartile
]

{ #category : #applying }
DataFrame >> toColumn: columnName applyElementwise: aBlock [
	"Applies a given block to a column named columnName of a data frame"

	| column |
	column := (self column: columnName) asArray.
	column := column collect: [ :each | aBlock value: each ].
	self column: columnName put: column asArray
]

{ #category : #applying }
DataFrame >> toColumnAt: columnNumber applyElementwise: aBlock [
	"Applies a given block to a column whose column index is columnNumber of a data frame"

	| columnName |
	columnName := self columnNames at: columnNumber.
	^ self toColumn: columnName applyElementwise: aBlock
]

{ #category : #applying }
DataFrame >> toColumns: arrayOfColumnNames applyElementwise: aBlock [
	"Applies a given block to columns whose names are present in the array arrayOfColumnNames of a data frame"

	arrayOfColumnNames do: [ :each |
		self toColumn: each applyElementwise: aBlock ]
]

{ #category : #applying }
DataFrame >> toColumnsAt: arrayOfColumnNumbers applyElementwise: aBlock [
	"Applies a given block to columns whose indices are present in the array arrayOfColumnNumbers of a data frame"

	arrayOfColumnNumbers do: [ :each |
		self toColumnAt: each applyElementwise: aBlock ]
]

{ #category : #converting }
DataFrame >> toMarkdown [
	" Prints the DataFrame as a Markdown formatted table"

	| markdown columnWidths dataFrame |
	dataFrame := self copy.
	dataFrame addColumn: dataFrame rowNames named: '#' atPosition: 1.
	markdown := WriteStream on: String new.
	markdown nextPutAll: '| '.

	columnWidths := dataFrame columnNames collect: [ :columnName |
		                | maxWidth |
		                maxWidth := columnName size.
		                dataFrame rows do: [ :row |
			                | value |
			                value := row at: columnName.
			                maxWidth := maxWidth max: value printString size ].
		                maxWidth ].

	dataFrame columnNames withIndexDo: [ :columnName :index |
		| paddedColumnName |
		paddedColumnName := columnName padRightTo: (columnWidths at: index).
		markdown nextPutAll: paddedColumnName , ' | ' ].
	markdown cr.
	markdown nextPutAll: '| '.

	columnWidths do: [ :width |
		| secondRow |
		secondRow := '-'.
		width - 1 timesRepeat: [ secondRow := secondRow , '-' ].
		markdown nextPutAll: secondRow , ' | ' ].

	markdown cr.

	dataFrame asArrayOfRows do: [ :row |
		markdown nextPutAll: '| '.
		row withIndexDo: [ :value :index |
			| paddedValue |
			paddedValue := value printString padRightTo:
				               (columnWidths at: index).
			markdown nextPutAll: paddedValue , ' | ' ].
		markdown cr ].

	^ markdown contents
]

{ #category : #geometry }
DataFrame >> transposed [
	"Returns a transposed DataFrame. Columns become rows and rows become columns."

	| transposedDf |
	transposedDf := DataFrame withRows: (self asArrayOfColumns).
	transposedDf rowNames: self columnNames.
	transposedDf columnNames: self rowNames.
	^ transposedDf
]

{ #category : #statistics }
DataFrame >> variance [
   "variance measures how far each number in the set is from the average value of the set. It is the square of standard deviation."

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
		self rowAt: i put: row asArray ]
]

{ #category : #enumerating }
DataFrame >> withIndexReject: elementAndIndexBlock [
	"Evaluate aBlock with each of the receiver's elements and index as the arguments.
	Collect into a new collection like the receiver, only those elements for
	which aBlock evaluates to false. Answer the new collection."
	^ self withIndexSelect: [ :row :index | (elementAndIndexBlock value: row value: index) not ]
]

{ #category : #enumerating }
DataFrame >> withIndexSelect: aBlock [
	"Evaluate aBlock with each of the receiver's elements and index as the arguments.
	Collect into a new collection like the receiver, only those elements for
	which aBlock evaluates to true. Answer the new collection."

	| selectedIndexes |

	selectedIndexes := (1 to: self numberOfRows) select: [ :index |
		aBlock value: (self at: index) value: index ].

	^ self rowsAt: selectedIndexes
]
