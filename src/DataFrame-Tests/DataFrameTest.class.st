Class {
	#name : #DataFrameTest,
	#superclass : #TestCase,
	#instVars : [
		'df'
	],
	#category : #'DataFrame-Tests'
}

{ #category : #initialization }
DataFrameTest >> setUp [

	df := DataFrame withRows: #(
		(Barcelona 1.609 true)
   		(Dubai 2.789 true)
   		(London 8.788 false)).
		
	df rowNames: #(A B C).
	df columnNames: #(City Population BeenThere).
]

{ #category : #tests }
DataFrameTest >> testAdd [

	| row expected |
	
	row := DataSeries withValues: #(Paris 2.141 true) name: #X.
	df add: row.
	
	expected := DataFrame withRows: #(
		(Barcelona 1.609 true)
   		(Dubai 2.789 true)
   		(London 8.788 false)
		(Paris 2.141 true)).
		
	expected rowNames: #(A B C X).
	expected columnNames: #(City Population BeenThere).
	
	self assert: df equals: expected.
]

{ #category : #tests }
DataFrameTest >> testAddColumn [

	| column expected |
	
	column := DataSeries withValues: #(2015 2010 2017) name: #Year.
	df addColumn: column.
	
	expected := DataFrame withRows: #(
		(Barcelona 1.609 true 2015)
   		(Dubai 2.789 true 2010)
   		(London 8.788 false 2017)).
		
	expected rowNames: #(A B C).
	expected columnNames: #(City Population BeenThere Year).
	
	self assert: df equals: expected.
]

{ #category : #tests }
DataFrameTest >> testAddColumnAtPosition [
	| column expected |
	
	column := DataSeries withValues: #(2015 2010 2017) name: #Year.
	df addColumn: column atPosition: 3.
	
	expected := DataFrame withRows: #(
		(Barcelona 1.609 2015 true)
   		(Dubai 2.789 2010 true)
   		(London 8.788 2017 false)).
		
	expected rowNames: #(A B C).
	expected columnNames: #(City Population Year BeenThere).
	
	self assert: df equals: expected.
]

{ #category : #tests }
DataFrameTest >> testAddColumnNameMustBeDistinct [

	| series |
	series := DataSeries withValues: #(1 2 3) name: #City.
	self should: [ df addColumn: series ] raise: Error.
]

{ #category : #tests }
DataFrameTest >> testAddColumnNamed [
	| expected |
	
	df addColumn: #(2015 2010 2017) named: #Year.
	
	expected := DataFrame withRows: #(
		(Barcelona 1.609 true 2015)
   		(Dubai 2.789 true 2010)
   		(London 8.788 false 2017)).
		
	expected rowNames: #(A B C).
	expected columnNames: #(City Population BeenThere Year).
	
	self assert: df equals: expected.
]

{ #category : #tests }
DataFrameTest >> testAddColumnNamedAtPosition [
	| expected |
	
	df addColumn: #(2015 2010 2017) named: #Year atPosition: 3.
	
	expected := DataFrame withRows: #(
		(Barcelona 1.609 2015 true)
   		(Dubai 2.789 2010 true)
   		(London 8.788 2017 false)).
		
	expected rowNames: #(A B C).
	expected columnNames: #(City Population Year BeenThere).
	
	self assert: df equals: expected.
]

{ #category : #tests }
DataFrameTest >> testAddColumnNamedNameMustBeDistinct [

	self should: [ df addColumn: #(1 2 3) named: #City ] raise: Error.
]

{ #category : #tests }
DataFrameTest >> testAddEmptyColumnNamed [

	| expected |
	
	expected := DataFrame withRows: #(
		(Barcelona 1.609 true nil)
   		(Dubai 2.789 true nil)
   		(London 8.788 false nil)).
		
	expected rowNames: #(A B C).
	expected columnNames: #(City Population BeenThere EmptyColumn).
		
	df addEmptyColumnNamed: #EmptyColumn.
	
	self assert: df equals: expected.
]

{ #category : #tests }
DataFrameTest >> testAddEmptyColumnNamedAtPosition [

	| expected |
	
	expected := DataFrame withRows: #(
		(Barcelona 1.609 nil true)
   		(Dubai 2.789 nil true)
   		(London 8.788 nil false)).
		
	expected rowNames: #(A B C).
	expected columnNames: #(City Population EmptyColumn BeenThere).
		
	df addEmptyColumnNamed: #EmptyColumn atPosition: 3.
	
	self assert: df equals: expected.
]

{ #category : #tests }
DataFrameTest >> testAddEmptyRowNamed [

	| expected |
	
	expected := DataFrame withRows: #(
		(Barcelona 1.609 true)
   		(Dubai 2.789 true)
   		(London 8.788 false)
		(nil nil nil)).
		
	expected rowNames: #(A B C X).
	expected columnNames: #(City Population BeenThere).
		
	df addEmptyRowNamed: #X.
	
	self assert: df equals: expected.
]

{ #category : #tests }
DataFrameTest >> testAddEmptyRowNamedAtPosition [

	| expected |
	
	expected := DataFrame withRows: #(
		(Barcelona 1.609 true)
   		(Dubai 2.789 true)
		(nil nil nil)
   		(London 8.788 false)).
		
	expected rowNames: #(A B X C).
	expected columnNames: #(City Population BeenThere).
		
	df addEmptyRowNamed: #X atPosition: 3.
	
	self assert: df equals: expected.
]

{ #category : #tests }
DataFrameTest >> testAddRow [

	| row expected |
	
	row := DataSeries withValues: #(Paris 2.141 true) name: #X.
	df addRow: row.
	
	expected := DataFrame withRows: #(
		(Barcelona 1.609 true)
   		(Dubai 2.789 true)
   		(London 8.788 false)
		(Paris 2.141 true)).
		
	expected rowNames: #(A B C X).
	expected columnNames: #(City Population BeenThere).
	
	self assert: df equals: expected.
]

{ #category : #tests }
DataFrameTest >> testAddRowAtPosition [
	| row expected |
	
	row := DataSeries withValues: #(Paris 2.141 true) name: #X.
	df addRow: row atPosition: 2.
	
	expected := DataFrame withRows: #(
		(Barcelona 1.609 true)
		(Paris 2.141 true)
   		(Dubai 2.789 true)
   		(London 8.788 false)).
		
	expected rowNames: #(A X B C).
	expected columnNames: #(City Population BeenThere).
	
	self assert: df equals: expected.
]

{ #category : #tests }
DataFrameTest >> testAddRowNameMustBeDistinct [

	| series |
	series := DataSeries withValues: #(1 2 3) name: #A.
	self should: [ df addRow: series ] raise: Error.
]

{ #category : #tests }
DataFrameTest >> testAddRowNamed [
	| expected |
	
	df addRow: #(Paris 2.141 true) named: #X.
	
	expected := DataFrame withRows: #(
		(Barcelona 1.609 true)
   		(Dubai 2.789 true)
   		(London 8.788 false)
		(Paris 2.141 true)).
		
	expected rowNames: #(A B C X).
	expected columnNames: #(City Population BeenThere).
	
	self assert: df equals: expected.
]

{ #category : #tests }
DataFrameTest >> testAddRowNamedAtPosition [
	| expected |
	
	df addRow: #(Paris 2.141 true) named: #X atPosition: 2.
	
	expected := DataFrame withRows: #(
		(Barcelona 1.609 true)
		(Paris 2.141 true)
   		(Dubai 2.789 true)
   		(London 8.788 false)).
		
	expected rowNames: #(A X B C).
	expected columnNames: #(City Population BeenThere).
	
	self assert: df equals: expected.
]

{ #category : #tests }
DataFrameTest >> testAddRowNamedNameMustBeDistinct [

	self should: [ df addRow: #(1 2 3) named: #A ] raise: Error.
]

{ #category : #tests }
DataFrameTest >> testAddRowSizeMismatch [

	| aBlock |
	aBlock := [ df addRow: #(1 2) named: #TooSmall ].
	
	self should: aBlock raise: SizeMismatch.
]

{ #category : #tests }
DataFrameTest >> testAsArrayOfColumns [

	| expected |
	
	expected := #(
		('Barcelona' 'Dubai' 'London')
		(1.609 2.789 8.788)
   		(true true false)).
	
	self assert: df asArrayOfColumns equals: expected.
	

]

{ #category : #tests }
DataFrameTest >> testAsArrayOfRows [

	| expected |
	
	expected := {
		#('Barcelona' 1.609 true) asDataSeries name: 'A'; keys: df columnNames; yourself .
   		#('Dubai' 2.789 true) asDataSeries name: 'B'; keys: df columnNames; yourself .
   		#('London' 8.788 false) asDataSeries name: 'C'; keys: df columnNames; yourself
	}.
	
	self assert: df asArrayOfRows equals: expected.
	

]

{ #category : #tests }
DataFrameTest >> testAt [

	| actual expected |

	expected := DataSeries withValues:
		#('Dubai' 2.789 true).
		
	expected name: #B.
	expected keys: df columnNames.
	
	actual := df at: 2.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataFrameTest >> testAtAt [

	self assert: (df at: 2 at: 1) equals: 'Dubai'.
]

{ #category : #tests }
DataFrameTest >> testAtAtPut [

	| expectedDataFrame |
	
	expectedDataFrame := DataFrame withRows: #(
		(Barcelona 1.609 true)
   		(Dubai 2.789 true)
   		(London 1000 false)).
		
	expectedDataFrame rowNames: df rowNames.
	expectedDataFrame columnNames: df columnNames.
		
	df at: 3 at: 2 put: 1000.
			
	self assert: df equals: expectedDataFrame. 
]

{ #category : #tests }
DataFrameTest >> testAtAtTransform [

	| expected |

	expected := DataFrame
		withRows: #(
			(Barcelona 1.609 true)
   			(Dubai 2 true)
   			(London 8.788 false))
		rowNames: #(A B C)
		columnNames: #(City Population BeenThere).
		
	df at: 2 at: 2 transform: [ :value | value floor ].
	self assert: df equals: expected
]

{ #category : #tests }
DataFrameTest >> testAtTransform [

	| expected |

	expected := DataFrame
		withRows: #(
			(Barcelona 1.609 true)
   			(Dubai 0 true)
   			(London 8.788 false))
		rowNames: #(A B C)
		columnNames: #(City Population BeenThere).
		
	df at: 2 transform: [ :row | row at: #Population put: 0; yourself ].
	self assert: df equals: expected
]

{ #category : #tests }
DataFrameTest >> testCollect [
	| expectedDf expectedResult actualResult |
	
	expectedDf := DataFrame withRows: #(
		(Barcelona 1.609 true)
   		(Dubai 2.789 true)
   		(London 8.788 false)).
		
	expectedDf rowNames: #(A B C).
	expectedDf columnNames: #(City Population BeenThere).
	
	expectedResult := DataFrame withRows: #(
		('BARCELONA' 1)
   		('DUBAI' 2)
   		('LONDON' 8)).
		
	expectedResult rowNames: #(A B C).
	expectedResult columnNames: #(City Population).
	
	actualResult := df collect: [ :row |
		row at: #City put: (row at: #City) asUppercase.
		row at: #Population put: (row at: #Population) asInteger.
		row removeAt: #BeenThere.
		row ].
	
	self assert: actualResult equals: expectedResult.
	self assert: df equals: expectedDf.
]

{ #category : #tests }
DataFrameTest >> testColumn [

	| actualSeries expectedSeries |

	expectedSeries := DataSeries withValues:
		#(Barcelona Dubai London).
	
	expectedSeries name: #City.
	expectedSeries keys: df rowNames.
	
	actualSeries := df column: #City.
	
	self assert: actualSeries equals: expectedSeries.
]

{ #category : #tests }
DataFrameTest >> testColumnAt [

	| actualSeries expectedSeries |

	expectedSeries := DataSeries withValues:
		#(Barcelona Dubai London).
	
	expectedSeries name: #City.
	expectedSeries keys: df rowNames.
	
	actualSeries := df columnAt: 1.
	
	self assert: actualSeries equals: expectedSeries.
]

{ #category : #tests }
DataFrameTest >> testColumnAtPut [

	| actual expected |

	expected := DataFrame withRows: #(
		('X' 1.609 0)
   		('Y' 2.789 1)
   		('Z' 8.788 0)).
		
	expected rowNames: #(A B C).
	expected columnNames: #(City Population BeenThere).
	
	actual := df.
	actual columnAt: 1 put: #('X' 'Y' 'Z').
	actual columnAt: 3 put: #(0 1 0).
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataFrameTest >> testColumnAtTransform [

	| expected |

	expected := DataFrame
		withRows: #(
			(Barcelona 1.609 true)
   			(Dubai 0 true)
   			(London 8.788 false))
		rowNames: #(A B C)
		columnNames: #(City Population BeenThere).
		
	df columnAt: 2 transform: [ :column | column at: #B put: 0; yourself ].
	self assert: df equals: expected
]

{ #category : #tests }
DataFrameTest >> testColumnIfAbsent [

	| exceptionBlockEvaluated |
	
	exceptionBlockEvaluated := false.
	
	df column: #NoSuchColumn
		ifAbsent: [ exceptionBlockEvaluated := true ].
		
	self assert: exceptionBlockEvaluated.
]

{ #category : #tests }
DataFrameTest >> testColumnNames [
	| newNames |
	newNames := #(X Y Z).
	df columnNames: newNames.
	self assert: df columnNames equals: newNames asOrderedCollection
]

{ #category : #tests }
DataFrameTest >> testColumnNamesMustBeDistinct [
	| newNames |
	newNames := #(x y y).
	self should: [ df columnNames: newNames ] raise: Error.
]

{ #category : #tests }
DataFrameTest >> testColumnNamesSizeMismatch [
	| tooManyNames notEnoughNames |
	
	tooManyNames := #(W X Y Z).
	notEnoughNames := #(Y Z).
	
	self should: [ df columnNames: tooManyNames ] raise: SizeMismatch.
	self should: [ df columnNames: notEnoughNames ] raise: SizeMismatch.
]

{ #category : #tests }
DataFrameTest >> testColumnNotFound [
	self
		should: [ df column: #NoSuchColumn ]
		raise: LibrarySymbolNotFoundError.
]

{ #category : #tests }
DataFrameTest >> testColumnPut [

	| actual expected |

	expected := DataFrame withRows: #(
		('X' 1.609 0)
   		('Y' 2.789 1)
   		('Z' 8.788 0)).
		
	expected rowNames: #(A B C).
	expected columnNames: #(City Population BeenThere).
	
	actual := df.
	actual column: #City put: #('X' 'Y' 'Z').
	actual column: #BeenThere put: #(0 1 0).
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataFrameTest >> testColumnPutIfAbsent [

	| expected exceptionBlockEvaluated |
	
	exceptionBlockEvaluated := false.
	
	expected := DataFrame
		withRows: #(
			(Barcelona 1.609 true)
   			(Dubai 2.789 true)
   			(London 8.788 false))
		rowNames: #(A B C)
		columnNames: #(City Population BeenThere).
	
	df column: #NoSuchColumn
		put: #(0 0 0)
		ifAbsent: [ exceptionBlockEvaluated := true ].
		
	self assert: df equals: expected.
	self assert: exceptionBlockEvaluated.
]

{ #category : #tests }
DataFrameTest >> testColumnPutNotFound [
	self
		should: [ df column: #NoSuchColumn put: #(0 0 0) ]
		raise: LibrarySymbolNotFoundError.
]

{ #category : #tests }
DataFrameTest >> testColumnTransform [

	| expected |

	expected := DataFrame
		withRows: #(
			(Barcelona 1.609 true)
   			(Dubai 0 true)
   			(London 8.788 false))
		rowNames: #(A B C)
		columnNames: #(City Population BeenThere).
		
	df column: #Population transform: [ :column | column at: #B put: 0; yourself ].
	self assert: df equals: expected
]

{ #category : #tests }
DataFrameTest >> testColumnTransformIfAbsent [

	| expected exceptionBlockEvaluated |

	exceptionBlockEvaluated := false.
	
	expected := DataFrame
		withRows: #(
			(Barcelona 1.609 true)
   			(Dubai 2.789 true)
   			(London 8.788 false))
		rowNames: #(A B C)
		columnNames: #(City Population BeenThere).
		
	df column: #NoSuchColumn
		transform: [ :column | column at: #B put: 0 ]
		ifAbsent: [ exceptionBlockEvaluated := true ].
		
	self assert: df equals: expected.
	self assert: exceptionBlockEvaluated.
]

{ #category : #tests }
DataFrameTest >> testColumnTransformNotFound [

	| expected |
	
	expected := DataFrame
		withRows: #(
			(Barcelona 1.609 true)
   			(Dubai 2.789 true)
   			(London 8.788 false))
		rowNames: #(A B C)
		columnNames: #(City Population BeenThere).
		
	self
		should: [
			df column: #NoSuchColumn
				transform: [ :column | column at: #B put: 0 ] ]
		raise: LibrarySymbolNotFoundError.
		
	self assert: df equals: expected.
]

{ #category : #tests }
DataFrameTest >> testColumns [

	| columnNames actualDataFrame expectedDataFrame |
	
	columnNames := #(City BeenThere).
	
	expectedDataFrame := DataFrame withRows: #(
		(Barcelona true)
   		(Dubai true)
   		(London false)).
		
	expectedDataFrame rowNames: df rowNames.
	expectedDataFrame columnNames: columnNames.
	
	actualDataFrame := df columns: columnNames.
	
	self assert: actualDataFrame equals: expectedDataFrame.
]

{ #category : #tests }
DataFrameTest >> testColumnsAt [

	| columnNumbers actualDataFrame expectedDataFrame |
	
	columnNumbers := #(1 3).
	
	expectedDataFrame := DataFrame withRows: #(
		(Barcelona true)
   		(Dubai true)
   		(London false)).
		
	expectedDataFrame rowNames: df rowNames.
	expectedDataFrame columnNames:
		(columnNumbers collect: [ :i |
			df columnNames at: i ]).
	
	actualDataFrame := df columnsAt: columnNumbers.
	
	self assert: actualDataFrame equals: expectedDataFrame.
]

{ #category : #tests }
DataFrameTest >> testColumnsAtPut [
	| rowNames columnNames dataFrame newColumns expected |
	
	rowNames := #('01:10' '01:30' '01:50' '02:10' '02:30') collect: #asTime.
	columnNames := #(temperature precipitation type).
	
	dataFrame := DataFrame
		withRows: #(
			(2.4 true rain)
			(0.5 true rain)
			(-1.2 true snow)
			(-2.3 false -)
			(3.2 true rain))
		rowNames: rowNames
		columnNames: columnNames.
		
	newColumns := #(
		(1 1 1 1 1)
		(2 2 2 2 2)).
		
	expected := DataFrame
		withRows: #(
			(2 true 1)
			(2 true 1)
			(2 true 1)
			(2 false 1)
			(2 true 1))
		rowNames: rowNames
		columnNames: columnNames.
	
	dataFrame columnsAt: #(3 1) put: newColumns.
	self assert: dataFrame equals: expected.
]

{ #category : #tests }
DataFrameTest >> testColumnsFromTo [

	| actualDataFrame expectedDataFrame |
		
	expectedDataFrame := DataFrame withRows: #(
		(1.609 true)
   		(2.789 true)
   		(8.788 false)).
		
	expectedDataFrame rowNames: df rowNames.
	expectedDataFrame columnNames: #(Population BeenThere).
	
	actualDataFrame := df columnsFrom: 2 to: 3.
	
	self assert: actualDataFrame equals: expectedDataFrame.
]

{ #category : #tests }
DataFrameTest >> testColumnsFromToPut [
	| rowNames columnNames dataFrame newColumns expected |
	
	rowNames := #('01:10' '01:30' '01:50' '02:10' '02:30') collect: #asTime.
	columnNames := #(temperature precipitation type).
	
	dataFrame := DataFrame
		withRows: #(
			(2.4 true rain)
			(0.5 true rain)
			(-1.2 true snow)
			(-2.3 false -)
			(3.2 true rain))
		rowNames: rowNames
		columnNames: columnNames.
		
	newColumns := #(
		(1 1 1 1 1)
		(2 2 2 2 2)).
		
	expected := DataFrame
		withRows: #(
			(2.4 2 1)
			(0.5 2 1)
			(-1.2 2 1)
			(-2.3 2 1)
			(3.2 2 1))
		rowNames: rowNames
		columnNames: columnNames.
	
	dataFrame columnsFrom: 3 to: 2 put: newColumns.
	self assert: dataFrame equals: expected.
]

{ #category : #tests }
DataFrameTest >> testColumnsPut [
	| rowNames columnNames dataFrame newColumns expected |
	
	rowNames := #('01:10' '01:30' '01:50' '02:10' '02:30') collect: #asTime.
	columnNames := #(temperature precipitation type).
	
	dataFrame := DataFrame
		withRows: #(
			(2.4 true rain)
			(0.5 true rain)
			(-1.2 true snow)
			(-2.3 false -)
			(3.2 true rain))
		rowNames: rowNames
		columnNames: columnNames.
		
	newColumns := #(
		(1 1 1 1 1)
		(2 2 2 2 2)).
		
	expected := DataFrame
		withRows: #(
			(2 true 1)
			(2 true 1)
			(2 true 1)
			(2 false 1)
			(2 true 1))
		rowNames: rowNames
		columnNames: columnNames.
	
	dataFrame columns: #(type temperature) put: newColumns.
	self assert: dataFrame equals: expected.
]

{ #category : #tests }
DataFrameTest >> testCreateDataFrameWith3ColumnsAndNoRows [
	| dataFrame |
	dataFrame := DataFrame new: 0@3.
	
	self assert: dataFrame class equals: DataFrame.
	self assert: dataFrame dimensions equals: 0@3.
	self assert: dataFrame rowNames equals: #() asOrderedCollection.
	self assert: dataFrame columnNames equals: #(1 2 3) asOrderedCollection.
]

{ #category : #tests }
DataFrameTest >> testCreateDataFrameWithColumns [

	| columns dataFrame expectedValues |
	
	columns := #(
		('Robb Stark' 'Jon Snow' 'Eddard Stark')
    	(3 4 1)
      	(true false true)).
	
	dataFrame := DataFrame withColumns: columns.
	
	self assert: dataFrame rowNames equals: #(1 2 3) asOrderedCollection.
	self assert: dataFrame columnNames equals: #(1 2 3) asOrderedCollection.
	
	"We know that it works, because we have tests for it in DataFrameInternalTests"
	expectedValues := DataFrameInternal withColumns: columns.
	
	self assert: dataFrame contents equals: expectedValues.
]

{ #category : #tests }
DataFrameTest >> testCreateDataFrameWithColumnsColumnNames [

	| columns columnNames dataFrame expectedValues |
	
	columns := #(
		('Robb Stark' 'Jon Snow' 'Eddard Stark')
    	(3 4 1)
      	(true false true)).
	
	columnNames := #(Name Book IsAlive) asOrderedCollection.
	dataFrame := DataFrame
		withColumns: columns
		columnNames: columnNames.
	
	self assert: dataFrame rowNames equals: #(1 2 3) asOrderedCollection.
	self assert: dataFrame columnNames equals: columnNames.
	
	"We know that it works, because we have tests for it in DataFrameInternalTests"
	expectedValues := DataFrameInternal withColumns: columns.
	
	self assert: dataFrame contents equals: expectedValues.
]

{ #category : #tests }
DataFrameTest >> testCreateDataFrameWithColumnsRowNames [

	| columns rowNames dataFrame expectedValues |
	
	columns := #(
		('Robb Stark' 'Jon Snow' 'Eddard Stark')
    	(3 4 1)
      	(true false true)).
	
	rowNames := #(A B C) asOrderedCollection.
	dataFrame := DataFrame
		withColumns: columns
		rowNames: rowNames.
	
	self assert: dataFrame rowNames equals: rowNames.
	self assert: dataFrame columnNames equals: #(1 2 3) asOrderedCollection.
	
	"We know that it works, because we have tests for it in DataFrameInternalTests"
	expectedValues := DataFrameInternal withColumns: columns.
	
	self assert: dataFrame contents equals: expectedValues.
]

{ #category : #tests }
DataFrameTest >> testCreateDataFrameWithColumnsRowNamesColumnNames [

	| columns rowNames columnNames dataFrame expectedValues |
	
	columns := #(
		('Robb Stark' 'Jon Snow' 'Eddard Stark')
    	(3 4 1)
      	(true false true)).
	
	rowNames := #(A B C) asOrderedCollection.
	columnNames := #(Name Book IsAlive) asOrderedCollection.
	
	dataFrame := DataFrame
		withColumns: columns
		rowNames: rowNames
		columnNames: columnNames.
	
	self assert: dataFrame rowNames equals: rowNames.
	self assert: dataFrame columnNames equals: columnNames.
	
	"We know that it works, because we have tests for it in DataFrameInternalTests"
	expectedValues := DataFrameInternal withColumns: columns.
	
	self assert: dataFrame contents equals: expectedValues.
]

{ #category : #tests }
DataFrameTest >> testCreateDataFrameWithDataFrameInternalRowNamesColumnNames [

	| rows dataFrameInternal rowNames columnNames dataFrame expectedValues |
	
	rows := #(
		('Robb Stark' 3 true)
    	('Jon Snow' 4 false)
      	('Eddard Stark' 1 true)).
	
	dataFrameInternal := DataFrameInternal withRows: rows.
	rowNames := #(A B C) asOrderedCollection.
	columnNames := #(Name Book IsAlive) asOrderedCollection.
	
	dataFrame := DataFrame
		withDataFrameInternal: dataFrameInternal
		rowNames: rowNames
		columnNames: columnNames.
	
	self assert: dataFrame rowNames equals: rowNames.
	self assert: dataFrame columnNames equals: columnNames.
	
	"We know that it works, because we have tests for it in DataFrameInternalTests"
	expectedValues := DataFrameInternal withRows: rows.
	
	self assert: dataFrame contents equals: expectedValues.
]

{ #category : #tests }
DataFrameTest >> testCreateDataFrameWithRows [

	| rows dataFrame expectedValues |
	
	rows := #(
		('Robb Stark' 3 true)
    	('Jon Snow' 4 false)
      	('Eddard Stark' 1 true)).
	
	dataFrame := DataFrame
		withRows: rows.
	
	self assert: dataFrame rowNames equals: #(1 2 3) asOrderedCollection.
	self assert: dataFrame columnNames equals: #(1 2 3) asOrderedCollection.
	
	"We know that it works, because we have tests for it in DataFrameInternalTests"
	expectedValues := DataFrameInternal withRows: rows.
	
	self assert: dataFrame contents equals: expectedValues.
]

{ #category : #tests }
DataFrameTest >> testCreateDataFrameWithRowsColumnNames [

	| rows columnNames dataFrame expectedValues |
	
	rows := #(
		('Robb Stark' 3 true)
    	('Jon Snow' 4 false)
      	('Eddard Stark' 1 true)).
	
	columnNames := #(Name Book IsAlive) asOrderedCollection.
	
	dataFrame := DataFrame
		withRows: rows
		columnNames: columnNames.
	
	self assert: dataFrame rowNames equals: #(1 2 3) asOrderedCollection.
	self assert: dataFrame columnNames equals: columnNames.
	
	"We know that it works, because we have tests for it in DataFrameInternalTests"
	expectedValues := DataFrameInternal withRows: rows.
	
	self assert: dataFrame contents equals: expectedValues.
]

{ #category : #tests }
DataFrameTest >> testCreateDataFrameWithRowsRowNames [

	| rows rowNames dataFrame expectedValues |
	
	rows := #(
		('Robb Stark' 3 true)
    	('Jon Snow' 4 false)
      	('Eddard Stark' 1 true)).
	
	rowNames := #(A B C) asOrderedCollection.
	
	dataFrame := DataFrame
		withRows: rows
		rowNames: rowNames.
	
	self assert: dataFrame rowNames equals: rowNames.
	self assert: dataFrame columnNames equals: #(1 2 3) asOrderedCollection.
	
	"We know that it works, because we have tests for it in DataFrameInternalTests"
	expectedValues := DataFrameInternal withRows: rows.
	
	self assert: dataFrame contents equals: expectedValues.
]

{ #category : #tests }
DataFrameTest >> testCreateDataFrameWithRowsRowNamesColumnNames [

	| rows rowNames columnNames dataFrame expectedValues |
	
	rows := #(
		('Robb Stark' 3 true)
    	('Jon Snow' 4 false)
      	('Eddard Stark' 1 true)).
	
	rowNames := #(A B C) asOrderedCollection.
	columnNames := #(Name Book IsAlive) asOrderedCollection.
	
	dataFrame := DataFrame
		withRows: rows
		rowNames: rowNames
		columnNames: columnNames.
	
	self assert: dataFrame rowNames equals: rowNames.
	self assert: dataFrame columnNames equals: columnNames.
	
	"We know that it works, because we have tests for it in DataFrameInternalTests"
	expectedValues := DataFrameInternal withRows: rows.
	
	self assert: dataFrame contents equals: expectedValues.
]

{ #category : #tests }
DataFrameTest >> testCreateEmptyDataFrame [
	| dataFrame |
	dataFrame := DataFrame new.
	
	self assert: dataFrame class equals: DataFrame.
	self assert: dataFrame dimensions equals: 0@0.
	self assert: dataFrame rowNames equals: #() asOrderedCollection.
	self assert: dataFrame columnNames equals: #() asOrderedCollection.
]

{ #category : #tests }
DataFrameTest >> testCreateEmptyDataFrameWithColumnNames [
	| columnNames dataFrame |
	
	columnNames := #(Name Age Nationality) asOrderedCollection.
	dataFrame := DataFrame withColumnNames: columnNames.
	
	self assert: dataFrame class equals: DataFrame.
	self assert: dataFrame dimensions equals: 0@3.
	self assert: dataFrame rowNames equals: #() asOrderedCollection.
	self assert: dataFrame columnNames equals: columnNames.
]

{ #category : #tests }
DataFrameTest >> testCreateEmptyDataFrameWithColumns [

	| dataFrame  |
	dataFrame := DataFrame withColumns: #().
	
	self assert: dataFrame class equals: DataFrame.
]

{ #category : #tests }
DataFrameTest >> testCreateEmptyDataFrameWithColumnsColumnNames [

	| dataFrame  |
	dataFrame := DataFrame withColumns: #() columnNames: #().
	
	self assert: dataFrame class equals: DataFrame.
]

{ #category : #tests }
DataFrameTest >> testCreateEmptyDataFrameWithColumnsRowNames [

	| dataFrame  |
	dataFrame := DataFrame withColumns: #() rowNames: #().
	
	self assert: dataFrame class equals: DataFrame.
]

{ #category : #tests }
DataFrameTest >> testCreateEmptyDataFrameWithColumnsRowNamesColumnNames [

	| dataFrame  |
	dataFrame := DataFrame withColumns: #() rowNames: #() columnNames: #().
	
	self assert: dataFrame class equals: DataFrame.
]

{ #category : #tests }
DataFrameTest >> testCreateEmptyDataFrameWithRowNames [
	| rowNames dataFrame |
	
	rowNames := #(A B C) asOrderedCollection.
	dataFrame := DataFrame withRowNames: rowNames.
	
	self assert: dataFrame class equals: DataFrame.
	self assert: dataFrame dimensions equals: 3@0.
	self assert: dataFrame rowNames equals: rowNames.
	self assert: dataFrame columnNames equals: #() asOrderedCollection.
]

{ #category : #tests }
DataFrameTest >> testCreateEmptyDataFrameWithRowNamesColumnNames [
	| rowNames columnNames dataFrame |
	
	rowNames := #(A B C) asOrderedCollection.
	columnNames := #(Name Age Nationality) asOrderedCollection.
	
	dataFrame := DataFrame
		withRowNames: rowNames
		columnNames: columnNames.
	
	self assert: dataFrame class equals: DataFrame.
	self assert: dataFrame dimensions equals: 3@3.
	self assert: dataFrame rowNames equals: rowNames.
	self assert: dataFrame columnNames equals: columnNames.
]

{ #category : #tests }
DataFrameTest >> testCreateEmptyDataFrameWithRows [

	| dataFrame  |
	dataFrame := DataFrame withRows: #().
	
	self assert: dataFrame class equals: DataFrame.
]

{ #category : #tests }
DataFrameTest >> testCreateEmptyDataFrameWithRowsColumnNames [

	| dataFrame  |
	dataFrame := DataFrame withRows: #() columnNames: #().
	
	self assert: dataFrame class equals: DataFrame.
]

{ #category : #tests }
DataFrameTest >> testCreateEmptyDataFrameWithRowsRowNames [

	| dataFrame  |
	dataFrame := DataFrame withRows: #() rowNames: #().
	
	self assert: dataFrame class equals: DataFrame.
]

{ #category : #tests }
DataFrameTest >> testCreateEmptyDataFrameWithRowsRowNamesColumnNames [

	| dataFrame  |
	dataFrame := DataFrame withRows: #() rowNames: #() columnNames: #().
	
	self assert: dataFrame class equals: DataFrame.
]

{ #category : #tests }
DataFrameTest >> testCrossTabulation [

	| dataFrame expected |
	
	dataFrame := DataFrame withRows: #(
		(Male Young)
		(Female Old)
		(Female Young)
		(Female Young)
		(Male Old)).
	dataFrame columnNames: #(Gender Age).
	
	expected := DataFrame withRows:
		#((1 2)(1 1)).
		
	expected rowNames: #(Female Male).
	expected columnNames: #(Old Young).	
	
	self assert: (dataFrame crossTabulate: #Gender with: #Age) equals: expected.
]

{ #category : #tests }
DataFrameTest >> testDetect [
	| actual expected |

	expected := DataSeries
		withKeys: df columnNames
		values: #(London 8.788 false)
		name: #C.
		
	actual := df detect:
		[ :row | (row at: #BeenThere) not ].
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataFrameTest >> testDetectIfNone [
	| actual expected |

	expected := DataSeries
		withKeys: df columnNames
		values: #(London 8.788 false)
		name: #C.
		
	actual := df
		detect: [ :row | (row at: #BeenThere) not ]
		ifNone: [ 'not found' ].
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataFrameTest >> testDetectIfNoneNotFound [
	| actual expected |
	
	expected := 'not found'.
		
	actual := df
		detect: [ :row | (row at: #City) = 'Paris' ]
		ifNone: [ 'not found' ].
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataFrameTest >> testDetectNotFound [
	self
		should: [ df detect: [ :row | row at: #City = 'Paris' ] ]
		raise: NotFound
]

{ #category : #tests }
DataFrameTest >> testDo [

	| actual expected |

	expected := OrderedCollection
		with: #(Barcelona 1.609 true) asDataSeries
		with: #(Dubai 2.789 true) asDataSeries
		with: #(London 8.788 false) asDataSeries.
		
	expected doWithIndex: [ :each :i |
		each keys: #(City Population BeenThere).
		each name: (#(A B C) at: i) ].
		
	actual := OrderedCollection new.
	
	df do: [ :each |
		actual add: each ].
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataFrameTest >> testDoCanModifyRows [
	| expected |

	expected := DataFrame
		withRows: #(
			(BARCELONA 1.609 true)
			(DUBAI 2.789 true)
			(LONDON 8.788 false))
		rowNames: df rowNames
		columnNames: df columnNames.
	
	df do: [ :row |
		row at: #City put: (row at: #City) asUppercase ].
	
	self assert: df equals: expected.
]

{ #category : #tests }
DataFrameTest >> testEquality [

	| df1 df2 |
	
	df1 := DataFrame withRows: #((1 2)(3 4)).
	df2 := DataFrame withRows: #((1 2)(3 4)).
	
	self assert: df1 equals: df2.
	self assert: (df1 = df2).
]

{ #category : #'find-select' }
DataFrameTest >> testFindAllAtColumn [

	df addRow: #('London' 8.788 false) named: #D.
	self assert: (df findAll: 'London' atColumn: 'City') equals: #('C' 'D') asOrderedCollection.
]

{ #category : #'find-select' }
DataFrameTest >> testFindAllAtColumnBoolean [

	df addRow: #(Barcelona 1.609 true) named: #D.
	self assert: (df findAll: true atColumn: 'BeenThere') equals: #('A' 'B' 'D') asOrderedCollection.
]

{ #category : #'find-select' }
DataFrameTest >> testFindAllAtColumnFloat [

	df addRow: #(Dubai 2.789 true) named: #D.
	self assert: (df findAll: 2.789 atColumn: 'Population') equals: #('B' 'D') asOrderedCollection.
]

{ #category : #'find-select' }
DataFrameTest >> testFindAllIndicesOfAtColumn [

	df addRow: #('London' 8.788 false) named: #D.
	self assert: (df findAllIndicesOf: 'London' atColumn: 'City') equals: #(3 4) asOrderedCollection.
]

{ #category : #'find-select' }
DataFrameTest >> testFindAllIndicesOfAtColumnBoolean [

	df addRow: #(Barcelona 1.609 true) named: #D.
	self assert: (df findAllIndicesOf: true atColumn: 'BeenThere') equals: #(1 2 4) asOrderedCollection.
]

{ #category : #'find-select' }
DataFrameTest >> testFindAllIndicesOfAtColumnFloat [

	df addRow: #(Dubai 2.789 true) named: #D.
	self assert: (df findAllIndicesOf: 2.789 atColumn: 'Population') equals: #(2 4) asOrderedCollection.
]

{ #category : #tests }
DataFrameTest >> testIndexOfColumnNamed [
	| expected actual |
	expected := 2.
	actual := df indexOfColumnNamed: #Population.
	self assert: actual equals: expected.
]

{ #category : #tests }
DataFrameTest >> testIndexOfColumnNamedIfAbsent [ 
	| expected actual exceptionBlockEvaluated |
	exceptionBlockEvaluated := false.
	expected := 2.
	
	actual := df
		indexOfColumnNamed: #Population
		ifAbsent: [ exceptionBlockEvaluated := true ].
		
	self assert: actual equals: expected.
	self deny: exceptionBlockEvaluated
]

{ #category : #tests }
DataFrameTest >> testIndexOfColumnNamedIfAbsentNotFound [
	| exceptionBlockEvaluated |
	exceptionBlockEvaluated := false.
	
	df indexOfColumnNamed: #NoSuchColumn
		ifAbsent: [ exceptionBlockEvaluated := true ].
		
	self assert: exceptionBlockEvaluated
]

{ #category : #tests }
DataFrameTest >> testIndexOfColumnNamedNotFound [
	self
		should: [ df indexOfColumnNamed: #NoSuchColumn ]
		raise: LibrarySymbolNotFoundError
]

{ #category : #tests }
DataFrameTest >> testIndexOfRowNamed [
	| expected actual |
	expected := 2.
	actual := df indexOfRowNamed: #B.
	self assert: actual equals: expected.
]

{ #category : #tests }
DataFrameTest >> testIndexOfRowNamedIfAbsent [ 
	| expected actual exceptionBlockEvaluated |
	exceptionBlockEvaluated := false.
	expected := 2.
	
	actual := df
		indexOfRowNamed: #B
		ifAbsent: [ exceptionBlockEvaluated := true ].
		
	self assert: actual equals: expected.
	self deny: exceptionBlockEvaluated
]

{ #category : #tests }
DataFrameTest >> testIndexOfRowNamedIfAbsentNotFound [
	| exceptionBlockEvaluated |
	exceptionBlockEvaluated := false.
	
	df indexOfRowNamed: #NoSuchRow
		ifAbsent: [ exceptionBlockEvaluated := true ].
		
	self assert: exceptionBlockEvaluated
]

{ #category : #tests }
DataFrameTest >> testIndexOfRowNamedNotFound [
	self
		should: [ df indexOfRowNamed: #NoSuchRow ]
		raise: LibrarySymbolNotFoundError
]

{ #category : #tests }
DataFrameTest >> testInequality [

	| df1 df2 df3 df4 df5 |
	
	"Other data frames will be compared to this one"
	df1 := DataFrame withRows: #((1 2)(3 4)).
	df1 rowNames: #(a b).
	df1 columnNames: #(x y).
	
	"This one has different row names"
	df2 := DataFrame withRows: #((1 2)(3 4)).
	df2 rowNames: #(c b).
	df2 columnNames: #(x y).
	
	"This one has different column names"
	df3 := DataFrame withRows: #((1 2)(3 4)).
	df3 rowNames: #(a b).
	df3 columnNames: #(x z).
	
	"This one has different dimensions"
	df4 := DataFrame withRows: #((1 2)(3 4)(5 6)).
	df4 rowNames: #(a b c).
	df4 columnNames: #(x z).
	
	"This one has different values"
	df5 := DataFrame withRows: #((1 2)(3 5)).
	df5 rowNames: #(a b).
	df5 columnNames: #(x z).

	self assert: (df2 = df1) not.
	self assert: (df3 = df1) not.
	self assert: (df4 = df1) not.
	self assert: (df5 = df1) not.
]

{ #category : #tests }
DataFrameTest >> testInjectInto [
	| numericDataFrame actual expected |
	
	numericDataFrame := DataFrame 
		withRows: #(
			(4.5 86 24)
			(2.3 60 14)
			(1.2 56 16)
			(-1.0 12 18))
		rowNames: #(A B C D)
		columnNames: #(temperature humidity wind).

	expected := DataSeries
		withKeys: #(temperature humidity wind)
		values: #(7.0 214 72)
		name: '(no name)'.
		
	actual := numericDataFrame inject: 0 into:
		[ :sum :each | sum + each ].
	
	self assert: actual equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testInnerJoin [
	| df2 expected |
	
	df2 := DataFrame withRows: #(
		(false 0)
   		(false 1)
   		(true 2))
		rowNames: #(A B C)
		columnNames: #(Capital TimesVisited).
	
	expected := DataFrame withRows: #(
		(Barcelona 1.609 true false 0)
   		(Dubai 2.789 true false 1)
   		(London 8.788 false true 2))
		rowNames: #(A B C)
		columnNames: #(City Population BeenThere Capital TimesVisited).
	
	self assert: (df innerJoin: df2) equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testInnerJoinNoIntersection [
	| df2 expected |
	
	df2 := DataFrame withRows: #(
		(false 0)
   		(false 1)
   		(true 2))
		rowNames: #(D E F)
		columnNames: #(Capital TimesVisited).
	
	expected := DataFrame withColumnNames: #(City Population BeenThere Capital TimesVisited).
	
	self assert: (df innerJoin: df2) equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testInnerJoinOn [

	| df2 expected |
	
	df := DataFrame withRows: #(
		('K0' 'A0' 0)
		('K1' 'A1' 1)
		('K2' 'A2' 2)
		)
		rowNames: #('1K0' '1K1' '1K2')
		columnNames: #(Key A B).
	
	df2 := DataFrame withRows: #(
		('K0' 'B0' true)
		('K1' 'B1' false)
		('K2' 'B2' true)
		('K3' 'B3' false)
		)
		rowNames: #('1K0' '1K1' '1K2' '1K3')
		columnNames: #(Key C D).
	
	expected := DataFrame withRows: #(
		('K0' 'A0' 0 'B0' true)
		('K1' 'A1' 1 'B1' false)
		('K2' 'A2' 2 'B2' true)
		)
		columnNames: #(Key A B C D).
		
	self assert: (df innerJoin: df2 on: 'Key') equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testInnerJoinOnEmpty [
	| df2 expected |
	
	df2 := DataFrame new.
	
	expected := DataFrame withColumnNames: #(City Population BeenThere).
	
	self assert: (df innerJoin: df2) equals: expected.
	self assert: (df2 innerJoin: df) equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testInnerJoinOnEmptyWithColumnNames [
	| df2 expected |
	
	df2 := DataFrame withColumnNames: #(Capital TimesVisited).
	
	expected := DataFrame withColumnNames: #(City Population BeenThere Capital TimesVisited).
	
	self assert: (df innerJoin: df2) equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testInnerJoinOnLeftOnRight [

	| df2 expected |
	
	df := DataFrame withRows: #(
		('K0' 'A0' 0)
		('K1' 'A1' 1)
		('K2' 'A2' 2)
		)
		rowNames: #('1K0' '1K1' '1K2')
		columnNames: #(Key1 A B).
	
	df2 := DataFrame withRows: #(
		('K0' 'B0' true)
		('K1' 'B1' false)
		('K2' 'B2' true)
		('K3' 'B3' false)
		)
		rowNames: #('1K0' '1K1' '1K2' '1K3')
		columnNames: #(Key2 C D).
	
	expected := DataFrame withRows: #(
		('K0' 'A0' 0 'K0' 'B0' true)
		('K1' 'A1' 1 'K1' 'B1' false)
		('K2' 'A2' 2 'K2' 'B2' true)
		)
		columnNames: #(Key1 A B Key2 C D).
		
	self assert: (df innerJoin: df2 onLeft: 'Key1' onRight: 'Key2') equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testInnerJoinOnLeftOnRightDuplicateKeys [

	| df2 expected |
	
	df := DataFrame withRows: #(
		('K0' 'A0' 0)
		('K1' 'A1' 1)
		('K1' 'A2' 2)
		('K2' 'A3' 3)
		('K0' 'A4' 4)
		)
		rowNames: #('1K0' '1K1' '2K1' '1K2' '2K0')
		columnNames: #(Key A B).
	
	df2 := DataFrame withRows: #(
		('K3' 'B0' false)
		('K2' 'B1' true)
		('K2' 'B2' false)
		('K1' 'B3' true)
		('K3' 'B4' false)
		('K3' 'B5' true)
		('K0' 'B6' false)
		)
		rowNames: #('1K3' '1K2' '2K2' '1K1' '2K3' '3K3' '1K0')
		columnNames: #(Key C D).
	
	expected := DataFrame withRows: #(
		('K0' 'A0' 0 'B6' false)
		('K1' 'A1' 1 'B3' true)
		('K1' 'A2' 2 'B3' true)
		('K2' 'A3' 3 'B1' true)
		('K2' 'A3' 3 'B2' false)
		('K0' 'A4' 4 'B6' false)
		)
		columnNames: #(Key A B C D).
		
	self assert: (df innerJoin: df2 onLeft: 'Key' onRight: 'Key') equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testInnerJoinOnLeftOnRightMissingKey [

	| df2 |
	
	df := DataFrame withRows: #(
		('K0' 'A0' 0)
		('K1' 'A1' 1)
		('K2' 'A2' 2)
		)
		rowNames: #('1K0' '1K1' '1K2')
		columnNames: #(Key1 A B).
	
	df2 := DataFrame withRows: #(
		('K0' 'B0' true)
		('K1' 'B1' false)
		('K2' 'B2' true)
		('K3' 'B3' false)
		)
		rowNames: #('1K0' '1K1' '1K2' '1K3')
		columnNames: #(Key2 C D).
		
	self should: [df innerJoin: df2 onLeft: 'Key' onRight: 'Key2'] raise: Error.
	self should: [df innerJoin: df2 onLeft: 'Key1' onRight: 'Key'] raise: Error.
	self should: [df innerJoin: df2 onLeft: 'Key' onRight: 'Key'] raise: Error.
]

{ #category : #splitjoin }
DataFrameTest >> testInnerJoinOnLeftOnRightNoIntersection [

	| df2 expected |
	
	df := DataFrame withRows: #(
		('K0' 'A0' 0)
		('K1' 'A1' 1)
		('K2' 'A2' 2)
		)
		rowNames: #('1K0' '1K1' '1K2')
		columnNames: #(Key A B).
	
	df2 := DataFrame withRows: #(
		('L0' 'B0' true)
		('L1' 'B1' false)
		('L2' 'B2' true)
		('L3' 'B3' false)
		)
		rowNames: #('1K0' '1K1' '1K2' '1K3')
		columnNames: #(Key C D).
	
	expected := DataFrame withColumnNames: #(Key A B C D).
		
	self assert: (df innerJoin: df2 onLeft: 'Key' onRight: 'Key') equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testInnerJoinOnLeftOnRightOnEmpty [

	| df2 |
	
	df := DataFrame withRows: #(
		('K0' 'A0' 0)
		('K1' 'A1' 1)
		('K2' 'A2' 2)
		)
		rowNames: #('1K0' '1K1' '1K2')
		columnNames: #(Key A B).
	
	df2 := DataFrame new.
		
	self should: [df innerJoin: df2 onLeft: 'Key' onRight: 'Key'] raise: Error.
]

{ #category : #splitjoin }
DataFrameTest >> testInnerJoinOnLeftOnRightOnEmptyWithColumnNames [

	| df2 expected |
	
	df := DataFrame withRows: #(
		('K0' 'A0' 0)
		('K1' 'A1' 1)
		('K2' 'A2' 2)
		)
		rowNames: #('1K0' '1K1' '1K2')
		columnNames: #(Key A B).
	
	df2 := DataFrame withColumnNames: #(Key C D).
	
	expected := DataFrame withColumnNames: #(Key A B C D).
	self assert: (df innerJoin: df2 onLeft: 'Key' onRight: 'Key') equals: expected.
	
	expected := DataFrame withColumnNames: #(Key C D A B).
	self assert: (df2 innerJoin: df onLeft: 'Key' onRight: 'Key') equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testInnerJoinOnLeftOnRightOnSelf [
	
	| expected |
	
	df := DataFrame withRows: #(
		('K0' 'A0' 0)
		('K1' 'A1' 1)
		('K2' 'A2' 2)
		)
		rowNames: #('1K0' '1K1' '1K2')
		columnNames: #(Key A B).	
	
	expected := DataFrame withRows: #(
		('K0' 'A0' 0 'A0' 0)
		('K1' 'A1' 1 'A1' 1)
		('K2' 'A2' 2 'A2' 2)
		)
		columnNames: #(Key A_x B_x A_y B_y).
		
	self assert: (df innerJoin: df onLeft: 'Key' onRight: 'Key') equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testInnerJoinOnLeftOnRightRowMismatch [

	| df2 expected |
	
	df := DataFrame withRows: #(
		('K0' 'A0' 0)
		('K3' 'A3' 3)
		('K2' 'A2' 2)
		)
		rowNames: #('1K0' '1K1' '1K2')
		columnNames: #(Key A B).
	
	df2 := DataFrame withRows: #(
		('K0' 'B0' true)
		('K1' 'B1' false)
		('K2' 'B2' true)
		('K3' 'B3' false)
		)
		rowNames: #('1K0' '1K1' '1K2' '1K3')
		columnNames: #(Key C D).
	
	expected := DataFrame withRows: #(
		('K0' 'A0' 0 'B0' true)
		('K3' 'A3' 3 'B3' false)
		('K2' 'A2' 2 'B2' true)
		)
		columnNames: #(Key A B C D).
		
	self assert: (df innerJoin: df2 onLeft: 'Key' onRight: 'Key') equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testInnerJoinOnLeftOnRightSameColumnNames [

	| df2 expected |
	
	df := DataFrame withRows: #(
		('K0' 'A0' 0)
		('K1' 'A1' 1)
		('K2' 'A2' 2)
		)
		rowNames: #('1K0' '1K1' '1K2')
		columnNames: #(Key A B).
	
	df2 := DataFrame withRows: #(
		('K0' 'B0' true)
		('K1' 'B1' false)
		('K2' 'B2' true)
		('K3' 'B3' false)
		)
		rowNames: #('1K0' '1K1' '1K2' '1K3')
		columnNames: #(Key A B).
	
	expected := DataFrame withRows: #(
		('K0' 'A0' 0 'B0' true)
		('K1' 'A1' 1 'B1' false)
		('K2' 'A2' 2 'B2' true)
		)
		columnNames: #(Key A_x B_x A_y B_y).
		
	self assert: (df innerJoin: df2 onLeft: 'Key' onRight: 'Key') equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testInnerJoinOnLeftOnRightSameKeyName [

	| df2 expected |
	
	df := DataFrame withRows: #(
		('K0' 'A0' 0)
		('K1' 'A1' 1)
		('K2' 'A2' 2)
		)
		rowNames: #('1K0' '1K1' '1K2')
		columnNames: #(Key A B).
	
	df2 := DataFrame withRows: #(
		('K0' 'B0' true)
		('K1' 'B1' false)
		('K2' 'B2' true)
		('K3' 'B3' false)
		)
		rowNames: #('1K0' '1K1' '1K2' '1K3')
		columnNames: #(Key C D).
	
	expected := DataFrame withRows: #(
		('K0' 'A0' 0 'B0' true)
		('K1' 'A1' 1 'B1' false)
		('K2' 'A2' 2 'B2' true)
		)
		columnNames: #(Key A B C D).
		
	self assert: (df innerJoin: df2 onLeft: 'Key' onRight: 'Key') equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testInnerJoinOnSelf [
	| expected |
	
	expected := DataFrame withRows: #(
		(Barcelona 1.609 true Barcelona 1.609 true)
   		(Dubai 2.789 true Dubai 2.789 true)
   		(London 8.788 false London 8.788 false))
		rowNames: #(A B C)
		columnNames: #(City_x Population_x BeenThere_x City_y Population_y BeenThere_y).
	
	self assert: (df innerJoin: df) equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testInnerJoinRowMismatch [
	| df2 expected |
	
	df2 := DataFrame withRows: #(
		(false 0)
   		(false 1)
   		(true 2))
		rowNames: #(A D C)
		columnNames: #(Capital TimesVisited).
	
	expected := DataFrame withRows: #(
		(Barcelona 1.609 true false 0)
   		(London 8.788 false true 2))
		rowNames: #(A C)
		columnNames: #(City Population BeenThere Capital TimesVisited).
	
	self assert: (df innerJoin: df2) equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testInnerJoinSameColumnNames [
	| df2 expected |
	
	df2 := DataFrame withRows: #(
		(false 0)
   		(false 1)
   		(true 2))
		rowNames: #(A D C)
		columnNames: #(Capital Population).
	
	expected := DataFrame withRows: #(
		(Barcelona 1.609 true false 0)
   		(London 8.788 false true 2))
		rowNames: #(A C)
		columnNames: #(City Population_x BeenThere Capital Population_y).
	
	self assert: (df innerJoin: df2) equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testLeftJoin [
	| df2 expected |
	
	df2 := DataFrame withRows: #(
		(false 0)
   		(false 1)
   		(true 2))
		rowNames: #(A B C)
		columnNames: #(Capital TimesVisited).
	
	expected := DataFrame withRows: #(
		(Barcelona 1.609 true false 0)
   		(Dubai 2.789 true false 1)
   		(London 8.788 false true 2))
		rowNames: #(A B C)
		columnNames: #(City Population BeenThere Capital TimesVisited).
	
	self assert: (df leftJoin: df2) equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testLeftJoinNoIntersection [
	| df2 expected |
	
	df2 := DataFrame withRows: #(
		(false 0)
   		(false 1)
   		(true 2))
		rowNames: #(D E F)
		columnNames: #(Capital TimesVisited).
	
	expected := DataFrame withRows: #(
		(Barcelona 1.609 true nil nil)
   		(Dubai 2.789 true nil nil)
   		(London 8.788 false nil nil))
		rowNames: #(A B C)
		columnNames: #(City Population BeenThere Capital TimesVisited).
	
	self assert: (df leftJoin: df2) equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testLeftJoinOn [

	| df2 expected |
	
	df := DataFrame withRows: #(
		('K0' 'A0' 0)
		('K1' 'A1' 1)
		('K2' 'A2' 2)
		)
		rowNames: #('1K0' '1K1' '1K2')
		columnNames: #(Key A B).
	
	df2 := DataFrame withRows: #(
		('K0' 'B0' true)
		('K1' 'B1' false)
		('K2' 'B2' true)
		('K3' 'B3' false)
		)
		rowNames: #('1K0' '1K1' '1K2' '1K3')
		columnNames: #(Key C D).
	
	expected := DataFrame withRows: #(
		('K0' 'A0' 0 'B0' true)
		('K1' 'A1' 1 'B1' false)
		('K2' 'A2' 2  'B2' true)
		)
		columnNames: #(Key A B C D).
		
	self assert: (df leftJoin: df2 on: 'Key') equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testLeftJoinOnEmpty [
	| df2 expected |
	
	df2 := DataFrame new.
	
	expected := DataFrame withColumnNames: #(City Population BeenThere).
	
	self assert: (df leftJoin: df2) equals: df.
	self assert: (df2 leftJoin: df) equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testLeftJoinOnEmptyWithColumnNames [
	| df2 expected |
	
	df2 := DataFrame withColumnNames: #(Capital TimesVisited).
	
	expected := DataFrame withRows: #(
		(Barcelona 1.609 true nil nil)
   		(Dubai 2.789 true nil nil)
   		(London 8.788 false nil nil))
		rowNames: #(A B C)
		columnNames: #(City Population BeenThere Capital TimesVisited).
	
	self assert: (df leftJoin: df2) equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testLeftJoinOnLeftOnRight [

	| df2 expected |
	
	df := DataFrame withRows: #(
		('K0' 'A0' 0)
		('K1' 'A1' 1)
		('K2' 'A2' 2)
		)
		rowNames: #('1K0' '1K1' '1K2')
		columnNames: #(Key1 A B).
	
	df2 := DataFrame withRows: #(
		('K0' 'B0' true)
		('K1' 'B1' false)
		('K2' 'B2' true)
		('K3' 'B3' false)
		)
		rowNames: #('1K0' '1K1' '1K2' '1K3')
		columnNames: #(Key2 C D).
	
	expected := DataFrame withRows: #(
		('K0' 'A0' 0 'K0' 'B0' true)
		('K1' 'A1' 1 'K1' 'B1' false)
		('K2' 'A2' 2 'K2' 'B2' true)
		)
		columnNames: #(Key1 A B Key2 C D).
		
	self assert: (df leftJoin: df2 onLeft: 'Key1' onRight: 'Key2') equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testLeftJoinOnLeftOnRightDuplicateKeys [

	| df2 expected |
	
	df := DataFrame withRows: #(
		('K0' 'A0' 0)
		('K1' 'A1' 1)
		('K1' 'A2' 2)
		('K2' 'A3' 3)
		('K0' 'A4' 4)
		('K5' 'A5' 5)
		('K6' 'A6' 6)
		)
		rowNames: #('1K0' '1K1' '2K1' '1K2' '2K0' '1K5' '1K6')
		columnNames: #(Key A B).
	
	df2 := DataFrame withRows: #(
		('K3' 'B0' false)
		('K2' 'B1' true)
		('K2' 'B2' false)
		('K1' 'B3' true)
		('K3' 'B4' false)
		('K3' 'B5' true)
		('K0' 'B6' false)
		)
		rowNames: #('1K3' '1K2' '2K2' '1K1' '2K3' '3K3' '1K0')
		columnNames: #(Key C D).
	
	expected := DataFrame withRows: #(
		('K0' 'A0' 0 'B6' false)
		('K1' 'A1' 1 'B3' true)
		('K1' 'A2' 2 'B3' true)
		('K2' 'A3' 3 'B1' true)
		('K2' 'A3' 3 'B2' false)
		('K0' 'A4' 4 'B6' false)
		('K5' 'A5' 5 nil nil)
		('K6' 'A6' 6 nil nil)
		)
		columnNames: #(Key A B C D).
		
	self assert: (df leftJoin: df2 onLeft: 'Key' onRight: 'Key') equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testLeftJoinOnLeftOnRightMissingKey [

	| df2 |
	
	df := DataFrame withRows: #(
		('K0' 'A0' 0)
		('K1' 'A1' 1)
		('K2' 'A2' 2)
		)
		rowNames: #('1K0' '1K1' '1K2')
		columnNames: #(Key1 A B).
	
	df2 := DataFrame withRows: #(
		('K0' 'B0' true)
		('K1' 'B1' false)
		('K2' 'B2' true)
		('K3' 'B3' false)
		)
		rowNames: #('1K0' '1K1' '1K2' '1K3')
		columnNames: #(Key2 C D).
		
	self should: [df leftJoin: df2 onLeft: 'Key' onRight: 'Key2'] raise: Error.
	self should: [df leftJoin: df2 onLeft: 'Key1' onRight: 'Key'] raise: Error.
	self should: [df leftJoin: df2 onLeft: 'Key' onRight: 'Key'] raise: Error.
]

{ #category : #splitjoin }
DataFrameTest >> testLeftJoinOnLeftOnRightNoIntersection [

	| df2 expected |
	
	df := DataFrame withRows: #(
		('K0' 'A0' 0)
		('K1' 'A1' 1)
		('K2' 'A2' 2)
		)
		rowNames: #('1K0' '1K1' '1K2')
		columnNames: #(Key A B).
	
	df2 := DataFrame withRows: #(
		('L0' 'B0' true)
		('L1' 'B1' false)
		('L2' 'B2' true)
		('L3' 'B3' false)
		)
		rowNames: #('1K0' '1K1' '1K2' '1K3')
		columnNames: #(Key C D).
	
	expected :=  DataFrame withRows: #(
		('K0' 'A0' 0 nil nil)
		('K1' 'A1' 1 nil nil)
		('K2' 'A2' 2 nil nil)
		)
		columnNames: #(Key A B C D).
		
	self assert: (df leftJoin: df2 onLeft: 'Key' onRight: 'Key') equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testLeftJoinOnLeftOnRightOnEmpty [

	| df2 |
	
	df := DataFrame withRows: #(
		('K0' 'A0' 0)
		('K1' 'A1' 1)
		('K2' 'A2' 2)
		)
		rowNames: #('1K0' '1K1' '1K2')
		columnNames: #(Key A B).
	
	df2 := DataFrame new.
		
	self should: [df leftJoin: df2 onLeft: 'Key' onRight: 'Key'] raise: Error.
]

{ #category : #splitjoin }
DataFrameTest >> testLeftJoinOnLeftOnRightOnEmptyWithColumnNames [

	| df2 expected |
	
	df := DataFrame withRows: #(
		('K0' 'A0' 0)
		('K1' 'A1' 1)
		('K2' 'A2' 2)
		)
		rowNames: #('1K0' '1K1' '1K2')
		columnNames: #(Key A B).
	
	df2 := DataFrame withColumnNames: #(Key C D).
		
	expected := DataFrame withRows: #(
		('K0' 'A0' 0 nil nil)
		('K1' 'A1' 1 nil nil)
		('K2' 'A2' 2 nil nil)
		)
		columnNames: #(Key A B C D).
	self assert: (df leftJoin: df2 onLeft: 'Key' onRight: 'Key') equals: expected.
	
	expected := DataFrame withColumnNames: #(Key C D A B).
	self assert: (df2 leftJoin: df onLeft: 'Key' onRight: 'Key') equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testLeftJoinOnLeftOnRightOnSelf [
	
	| expected |
	
	df := DataFrame withRows: #(
		('K0' 'A0' 0)
		('K1' 'A1' 1)
		('K2' 'A2' 2)
		)
		rowNames: #('1K0' '1K1' '1K2')
		columnNames: #(Key A B).	
	
	expected := DataFrame withRows: #(
		('K0' 'A0' 0 'A0' 0)
		('K1' 'A1' 1 'A1' 1)
		('K2' 'A2' 2 'A2' 2)
		)
		columnNames: #(Key A_x B_x A_y B_y).
		
	self assert: (df leftJoin: df onLeft: 'Key' onRight: 'Key') equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testLeftJoinOnLeftOnRightRowMismatch [

	| df2 expected |
	
	df := DataFrame withRows: #(
		('K0' 'A0' 0)
		('K3' 'A3' 3)
		('K2' 'A2' 2)
		)
		rowNames: #('1K0' '1K1' '1K2')
		columnNames: #(Key A B).
	
	df2 := DataFrame withRows: #(
		('K0' 'B0' true)
		('K1' 'B1' false)
		('K2' 'B2' true)
		('K3' 'B3' false)
		)
		rowNames: #('1K0' '1K1' '1K2' '1K3')
		columnNames: #(Key C D).
	
	expected := DataFrame withRows: #(
		('K0' 'A0' 0 'B0' true)
		('K3' 'A3' 3 'B3' false)
		('K2' 'A2' 2 'B2' true)
		)
		columnNames: #(Key A B C D).
		
	self assert: (df leftJoin: df2 onLeft: 'Key' onRight: 'Key') equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testLeftJoinOnLeftOnRightSameColumnNames [

	| df2 expected |
	
	df := DataFrame withRows: #(
		('K0' 'A0' 0)
		('K1' 'A1' 1)
		('K2' 'A2' 2)
		)
		rowNames: #('1K0' '1K1' '1K2')
		columnNames: #(Key A B).
	
	df2 := DataFrame withRows: #(
		('K0' 'B0' true)
		('K1' 'B1' false)
		('K2' 'B2' true)
		('K3' 'B3' false)
		)
		rowNames: #('1K0' '1K1' '1K2' '1K3')
		columnNames: #(Key A B).
	
	expected := DataFrame withRows: #(
		('K0' 'A0' 0 'B0' true)
		('K1' 'A1' 1 'B1' false)
		('K2' 'A2' 2 'B2' true)
		)
		columnNames: #(Key A_x B_x A_y B_y).
		
	self assert: (df leftJoin: df2 onLeft: 'Key' onRight: 'Key') equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testLeftJoinOnLeftOnRightSameKeyName [

	| df2 expected |
	
	df := DataFrame withRows: #(
		('K0' 'A0' 0)
		('K1' 'A1' 1)
		('K2' 'A2' 2)
		)
		rowNames: #('1K0' '1K1' '1K2')
		columnNames: #(Key A B).
	
	df2 := DataFrame withRows: #(
		('K0' 'B0' true)
		('K1' 'B1' false)
		('K2' 'B2' true)
		('K3' 'B3' false)
		)
		rowNames: #('1K0' '1K1' '1K2' '1K3')
		columnNames: #(Key C D).
	
	expected := DataFrame withRows: #(
		('K0' 'A0' 0 'B0' true)
		('K1' 'A1' 1 'B1' false)
		('K2' 'A2' 2 'B2' true)
		)
		columnNames: #(Key A B C D).
		
	self assert: (df leftJoin: df2 onLeft: 'Key' onRight: 'Key') equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testLeftJoinOnSelf [
	| expected |
	
	expected := DataFrame withRows: #(
		(Barcelona 1.609 true Barcelona 1.609 true)
   		(Dubai 2.789 true Dubai 2.789 true)
   		(London 8.788 false London 8.788 false))
		rowNames: #(A B C)
		columnNames: #(City_x Population_x BeenThere_x City_y Population_y BeenThere_y).
	
	self assert: (df leftJoin: df) equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testLeftJoinRowMismatch [
	| df2 expected |
	
	df2 := DataFrame withRows: #(
		(false 0)
   		(false 1)
   		(true 2))
		rowNames: #(A D C)
		columnNames: #(Capital TimesVisited).
	
	expected := DataFrame withRows: #(
		(Barcelona 1.609 true false 0)
   		(Dubai 2.789 true nil nil)
   		(London 8.788 false true 2))
		rowNames: #(A B C)
		columnNames: #(City Population BeenThere Capital TimesVisited).
	
	self assert: (df leftJoin: df2) equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testLeftJoinSameColumnNames [
	| df2 expected |
	
	df2 := DataFrame withRows: #(
		(false 0)
   		(false 1)
   		(true 2))
		rowNames: #(A D C)
		columnNames: #(Capital Population).
	
	expected := DataFrame withRows: #(
		(Barcelona 1.609 true false 0)
   		(Dubai 2.789 true nil nil)
   		(London 8.788 false true 2))
		rowNames: #(A B C)
		columnNames: #(City Population_x BeenThere Capital Population_y).
	
	self assert: (df leftJoin: df2) equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testOuterJoin [
	| df2 expected |
	
	df2 := DataFrame withRows: #(
		(false 0)
   		(false 1)
   		(true 2))
		rowNames: #(D B C)
		columnNames: #(Capital TimesVisited).
	
	expected := DataFrame withRows: #(
		(Barcelona 1.609 true nil nil)
   		(Dubai 2.789 true false 1)
   		(London 8.788 false true 2)
		(nil nil nil false 0))
		rowNames: #(A B C D)
		columnNames: #(City Population BeenThere Capital TimesVisited).
	
	self assert: (df outerJoin: df2) equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testOuterJoinNoIntersection [
	| df2 expected |
	
	df2 := DataFrame withRows: #(
		(false 0)
   		(false 1)
   		(true 2))
		rowNames: #(D E F)
		columnNames: #(Capital TimesVisited).
	
	expected := DataFrame withRows: #(
		(Barcelona 1.609 true nil nil)
   		(Dubai 2.789 true nil nil)
   		(London 8.788 false nil nil)
		(nil nil nil false 0)
   		(nil nil nil false 1)
   		(nil nil nil true 2))
		rowNames: #(A B C D E F)
		columnNames: #(City Population BeenThere Capital TimesVisited).
	
	self assert: (df outerJoin: df2) equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testOuterJoinOn [

	| df2 expected |
	
	df := DataFrame withRows: #(
		('K0' 'A0' 0)
		('K1' 'A1' 1)
		('K2' 'A2' 2)
		)
		rowNames: #('1K0' '1K1' '1K2')
		columnNames: #(Key A B).
	
	df2 := DataFrame withRows: #(
		('K0' 'B0' true)
		('K1' 'B1' false)
		('K2' 'B2' true)
		('K3' 'B3' false)
		)
		rowNames: #('1K0' '1K1' '1K2' '1K3')
		columnNames: #(Key C D).
	
	expected := DataFrame withRows: #(
		('K0' 'A0' 0 'B0' true)
		('K1' 'A1' 1 'B1' false)
		('K2' 'A2' 2 'B2' true)
		('K3' nil nil 'B3' false)
		)
		columnNames: #(Key A B C D).
		
	self assert: (df outerJoin: df2 on: 'Key') equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testOuterJoinOnEmpty [
	| df2 |
	
	df2 := DataFrame new.
	
	self assert: (df outerJoin: df2) equals: df.
	self assert: (df2 outerJoin: df) equals: df.
]

{ #category : #splitjoin }
DataFrameTest >> testOuterJoinOnEmptyWithColumnNames [
	| df2 expected |
	
	df2 := DataFrame withColumnNames: #(Capital TimesVisited).
	
	expected := DataFrame withRows: #(
		(Barcelona 1.609 true nil nil)
   		(Dubai 2.789 true nil nil)
   		(London 8.788 false nil nil))
		rowNames: #(A B C)
		columnNames: #(City Population BeenThere Capital TimesVisited).
	
	self assert: (df outerJoin: df2) equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testOuterJoinOnLeftOnRight [

	| df2 expected |
	
	df := DataFrame withRows: #(
		('K0' 'A0' 0)
		('K1' 'A1' 1)
		('K2' 'A2' 2)
		)
		rowNames: #('1K0' '1K1' '1K2')
		columnNames: #(Key1 A B).
	
	df2 := DataFrame withRows: #(
		('K0' 'B0' true)
		('K1' 'B1' false)
		('K2' 'B2' true)
		('K3' 'B3' false)
		)
		rowNames: #('1K0' '1K1' '1K2' '1K3')
		columnNames: #(Key2 C D).
	
	expected := DataFrame withRows: #(
		('K0' 'A0' 0 'K0' 'B0' true)
		('K1' 'A1' 1 'K1' 'B1' false)
		('K2' 'A2' 2 'K2' 'B2' true)
		(nil nil nil 'K3' 'B3' false)
		)
		columnNames: #(Key1 A B Key2 C D).
		
	self assert: (df outerJoin: df2 onLeft: 'Key1' onRight: 'Key2') equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testOuterJoinOnLeftOnRightDuplicateKeys [

	| df2 expected |
	
	df := DataFrame withRows: #(
		('K0' 'A0' 0)
		('K1' 'A1' 1)
		('K1' 'A2' 2)
		('K2' 'A3' 3)
		('K0' 'A4' 4)
		('K5' 'A5' 5)
		('K6' 'A6' 6)
		)
		rowNames: #('1K0' '1K1' '2K1' '1K2' '2K0' '1K5' '1K6')
		columnNames: #(Key A B).
	
	df2 := DataFrame withRows: #(
		('K3' 'B0' false)
		('K2' 'B1' true)
		('K2' 'B2' false)
		('K1' 'B3' true)
		('K3' 'B4' false)
		('K3' 'B5' true)
		('K0' 'B6' false)
		)
		rowNames: #('1K3' '1K2' '2K2' '1K1' '2K3' '3K3' '1K0')
		columnNames: #(Key C D).
	
	expected := DataFrame withRows: #(
		('K0' 'A0' 0 'B6' false)
		('K1' 'A1' 1 'B3' true)
		('K1' 'A2' 2 'B3' true)
		('K2' 'A3' 3 'B1' true)
		('K2' 'A3' 3 'B2' false)
		('K0' 'A4' 4 'B6' false)
		('K5' 'A5' 5 nil nil)
		('K6' 'A6' 6 nil nil)
		('K3' nil nil 'B0' false)
		('K3' nil nil 'B4' false)
		('K3' nil nil 'B5' true)
		)
		columnNames: #(Key A B C D).
		
	self assert: (df outerJoin: df2 onLeft: 'Key' onRight: 'Key') equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testOuterJoinOnLeftOnRightMissingKey [

	| df2 |
	
	df := DataFrame withRows: #(
		('K0' 'A0' 0)
		('K1' 'A1' 1)
		('K2' 'A2' 2)
		)
		rowNames: #('1K0' '1K1' '1K2')
		columnNames: #(Key1 A B).
	
	df2 := DataFrame withRows: #(
		('K0' 'B0' true)
		('K1' 'B1' false)
		('K2' 'B2' true)
		('K3' 'B3' false)
		)
		rowNames: #('1K0' '1K1' '1K2' '1K3')
		columnNames: #(Key2 C D).
		
	self should: [df outerJoin: df2 onLeft: 'Key' onRight: 'Key2'] raise: Error.
	self should: [df outerJoin: df2 onLeft: 'Key1' onRight: 'Key'] raise: Error.
	self should: [df outerJoin: df2 onLeft: 'Key' onRight: 'Key'] raise: Error.
]

{ #category : #splitjoin }
DataFrameTest >> testOuterJoinOnLeftOnRightNoIntersection [

	| df2 expected |
	
	df := DataFrame withRows: #(
		('K0' 'A0' 0)
		('K1' 'A1' 1)
		('K2' 'A2' 2)
		)
		rowNames: #('1K0' '1K1' '1K2')
		columnNames: #(Key A B).
	
	df2 := DataFrame withRows: #(
		('L0' 'B0' true)
		('L1' 'B1' false)
		('L2' 'B2' true)
		('L3' 'B3' false)
		)
		rowNames: #('1K0' '1K1' '1K2' '1K3')
		columnNames: #(Key C D).
	
	expected :=  DataFrame withRows: #(
		('K0' 'A0' 0 nil nil)
		('K1' 'A1' 1 nil nil)
		('K2' 'A2' 2 nil nil)
		('L0' nil nil 'B0' true)
		('L1' nil nil 'B1' false)
		('L2' nil nil 'B2' true)
		('L3' nil nil 'B3' false)
		)
		columnNames: #(Key A B C D).
		
	self assert: (df outerJoin: df2 onLeft: 'Key' onRight: 'Key') equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testOuterJoinOnLeftOnRightOnEmpty [

	| df2 |
	
	df := DataFrame withRows: #(
		('K0' 'A0' 0)
		('K1' 'A1' 1)
		('K2' 'A2' 2)
		)
		rowNames: #('1K0' '1K1' '1K2')
		columnNames: #(Key A B).
	
	df2 := DataFrame new.
		
	self should: [df outerJoin: df2 onLeft: 'Key' onRight: 'Key'] raise: Error.
]

{ #category : #splitjoin }
DataFrameTest >> testOuterJoinOnLeftOnRightOnEmptyWithColumnNames [

	| df2 expected |
	
	df := DataFrame withRows: #(
		('K0' 'A0' 0)
		('K1' 'A1' 1)
		('K2' 'A2' 2)
		)
		rowNames: #('1K0' '1K1' '1K2')
		columnNames: #(Key A B).
	
	df2 := DataFrame withColumnNames: #(Key C D).
		
	expected := DataFrame withRows: #(
		('K0' 'A0' 0 nil nil)
		('K1' 'A1' 1 nil nil)
		('K2' 'A2' 2 nil nil)
		)
		columnNames: #(Key A B C D).
	self assert: (df outerJoin: df2 onLeft: 'Key' onRight: 'Key') equals: expected.
	
	expected := DataFrame withRows: #(
		('K0' nil nil 'A0' 0)
		('K1' nil nil 'A1' 1)
		('K2' nil nil 'A2' 2)
		)
		columnNames: #(Key C D A B).
	self assert: (df2 outerJoin: df onLeft: 'Key' onRight: 'Key') equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testOuterJoinOnLeftOnRightOnSelf [
	
	| expected |
	
	df := DataFrame withRows: #(
		('K0' 'A0' 0)
		('K1' 'A1' 1)
		('K2' 'A2' 2)
		)
		rowNames: #('1K0' '1K1' '1K2')
		columnNames: #(Key A B).	
	
	expected := DataFrame withRows: #(
		('K0' 'A0' 0 'A0' 0)
		('K1' 'A1' 1 'A1' 1)
		('K2' 'A2' 2 'A2' 2)
		)
		columnNames: #(Key A_x B_x A_y B_y).
		
	self assert: (df outerJoin: df onLeft: 'Key' onRight: 'Key') equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testOuterJoinOnLeftOnRightRowMismatch [

	| df2 expected |
	
	df := DataFrame withRows: #(
		('K0' 'A0' 0)
		('K3' 'A3' 3)
		('K2' 'A2' 2)
		)
		rowNames: #('1K0' '1K1' '1K2')
		columnNames: #(Key A B).
	
	df2 := DataFrame withRows: #(
		('K0' 'B0' true)
		('K1' 'B1' false)
		('K2' 'B2' true)
		('K3' 'B3' false)
		)
		rowNames: #('1K0' '1K1' '1K2' '1K3')
		columnNames: #(Key C D).
	
	expected := DataFrame withRows: #(
		('K0' 'A0' 0 'B0' true)
		('K3' 'A3' 3 'B3' false)
		('K2' 'A2' 2 'B2' true)
		('K1' nil nil 'B1' false)
		)
		columnNames: #(Key A B C D).
		
	self assert: (df outerJoin: df2 onLeft: 'Key' onRight: 'Key') equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testOuterJoinOnLeftOnRightSameColumnNames [

	| df2 expected |
	
	df := DataFrame withRows: #(
		('K0' 'A0' 0)
		('K1' 'A1' 1)
		('K2' 'A2' 2)
		)
		rowNames: #('1K0' '1K1' '1K2')
		columnNames: #(Key A B).
	
	df2 := DataFrame withRows: #(
		('K0' 'B0' true)
		('K1' 'B1' false)
		('K2' 'B2' true)
		('K3' 'B3' false)
		)
		rowNames: #('1K0' '1K1' '1K2' '1K3')
		columnNames: #(Key A B).
	
	expected := DataFrame withRows: #(
		('K0' 'A0' 0 'B0' true)
		('K1' 'A1' 1 'B1' false)
		('K2' 'A2' 2 'B2' true)
		('K3' nil nil 'B3' false)
		)
		columnNames: #(Key A_x B_x A_y B_y).
		
	self assert: (df outerJoin: df2 onLeft: 'Key' onRight: 'Key') equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testOuterJoinOnLeftOnRightSameKeyName [

	| df2 expected |
	
	df := DataFrame withRows: #(
		('K0' 'A0' 0)
		('K1' 'A1' 1)
		('K2' 'A2' 2)
		)
		rowNames: #('1K0' '1K1' '1K2')
		columnNames: #(Key A B).
	
	df2 := DataFrame withRows: #(
		('K0' 'B0' true)
		('K1' 'B1' false)
		('K2' 'B2' true)
		('K3' 'B3' false)
		)
		rowNames: #('1K0' '1K1' '1K2' '1K3')
		columnNames: #(Key C D).
	
	expected := DataFrame withRows: #(
		('K0' 'A0' 0 'B0' true)
		('K1' 'A1' 1 'B1' false)
		('K2' 'A2' 2 'B2' true)
		('K3' nil nil 'B3' false)
		)
		columnNames: #(Key A B C D).
		
	self assert: (df outerJoin: df2 onLeft: 'Key' onRight: 'Key') equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testOuterJoinOnSelf [
	| expected |
	
	expected := DataFrame withRows: #(
		(Barcelona 1.609 true Barcelona 1.609 true)
   		(Dubai 2.789 true Dubai 2.789 true)
   		(London 8.788 false London 8.788 false))
		rowNames: #(A B C)
		columnNames: #(City_x Population_x BeenThere_x City_y Population_y BeenThere_y).
	
	self assert: (df outerJoin: df) equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testOuterJoinRowMismatch [
	| df2 expected |
	
	df2 := DataFrame withRows: #(
		(false 0)
   		(false 1)
   		(true 2))
		rowNames: #(A D C)
		columnNames: #(Capital TimesVisited).
	
	expected := DataFrame withRows: #(
		(Barcelona 1.609 true false 0)
   		(Dubai 2.789 true nil nil)
   		(London 8.788 false true 2)
		(nil nil nil false 1))
		rowNames: #(A B C D)
		columnNames: #(City Population BeenThere Capital TimesVisited).
	
	self assert: (df outerJoin: df2) equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testOuterJoinSameColumnNames [
	| df2 expected |
	
	df2 := DataFrame withRows: #(
		(false 0)
   		(false 1)
   		(true 2))
		rowNames: #(A D C)
		columnNames: #(Capital Population).
	
	expected := DataFrame withRows: #(
		(Barcelona 1.609 true false 0)
   		(Dubai 2.789 true nil nil)
   		(London 8.788 false true 2)
		(nil nil nil false 1))
		rowNames: #(A B C D)
		columnNames: #(City Population_x BeenThere Capital Population_y).
	
	self assert: (df outerJoin: df2) equals: expected.
]

{ #category : #tests }
DataFrameTest >> testPrintOn [

	| expected actual |
	
	expected := 'a DataFrame (3@3)'.
	
	actual := String new writeStream.
	df printOn: actual.
	actual := actual contents.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataFrameTest >> testRangeError [
	self should: [ df range ] raise: MessageNotUnderstood	"Instance of Character did not understand #Barcelona"
]

{ #category : #tests }
DataFrameTest >> testReject [
	| actual expected |

	expected := DataFrame
		withRows: #(
			(Dubai 2.789 true)
			(London 8.788 false))
		rowNames: #(B C)
		columnNames: df columnNames.
		
	actual := df reject:
		[ :row | (row at: #Population) < 2 ].
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataFrameTest >> testRejectEntireDataFrame [
	| actual expected |

	expected := DataFrame
		withRows: #().
		
	actual := df reject:
		[ :row | (row at: #Population) < 10 ].
	
	self assert: actual equals: expected.
]

{ #category : #removing }
DataFrameTest >> testRemoveColumn [

	| expected |
	
	expected := DataFrame withRows: #(
		(Barcelona true)
   		(Dubai true)
   		(London false)).
		
	expected rowNames: #(A B C).
	expected columnNames: #(City BeenThere).
		
	df removeColumn: #Population.
	
	self assert: df equals: expected.
]

{ #category : #removing }
DataFrameTest >> testRemoveColumnAt [

	| expected |
	
	expected := DataFrame withRows: #(
		(Barcelona true)
   		(Dubai true)
   		(London false)).
		
	expected rowNames: #(A B C).
	expected columnNames: #(City BeenThere).
		
	df removeColumnAt: 2.
	
	self assert: df equals: expected.
]

{ #category : #removing }
DataFrameTest >> testRemoveColumnAtOutOfRange [
	self should: [ df removeColumnAt: 100 ] raise: SubscriptOutOfBounds.
]

{ #category : #removing }
DataFrameTest >> testRemoveColumnNotFound [
	self should: [ df removeColumn: #NoSuchColumn ] raise: LibrarySymbolNotFoundError.
]

{ #category : #removing }
DataFrameTest >> testRemoveColumns [
	| expected |
	
	expected := DataFrame withRows: #(
		(true)
   		(true)
   		(false)).
		
	expected rowNames: #(A B C).
	expected columnNames: #(BeenThere).
		
	df removeColumns: #(City Population).
	self assert: df equals: expected.
]

{ #category : #removing }
DataFrameTest >> testRemoveColumnsAt [
	| expected |
	
	expected := DataFrame withRows: #(
		(true)
   		(true)
   		(false)).
		
	expected rowNames: #(A B C).
	expected columnNames: #(BeenThere).
		
	df removeColumnsAt: #(1 2).
	self assert: df equals: expected.
]

{ #category : #removing }
DataFrameTest >> testRemoveColumnsOfRowElementsSatisfingOnRow [

	| expected aBlock |
	df := DataFrame withRows: #(
		(1 2 3)
   		(Dubai 4 5.0)
   		(nil 8.788 false)).
		
	df rowNames: #(A B C).
	df columnNames: #(X Y Z).
	
	expected := DataFrame withRows: #(
		(2)
   		(4)
   		(8.788)).
		
	expected rowNames: #(A B C).
	expected columnNames: #(Y).
	
	aBlock := [ :rowElement | rowElement ~= 4 ].
	
	self assert: (df removeColumnsOfRowElementsSatisfing: aBlock onRow: 2) equals: expected.
]

{ #category : #removing }
DataFrameTest >> testRemoveColumnsOfRowElementsSatisfingOnRowAllTrue [

	| expected aBlock |
	
	expected := DataFrame withRows: #().
	aBlock := [ :rowElement | true ].
	
	self assert: (df removeColumnsOfRowElementsSatisfing: aBlock onRow: 2) equals: expected.
]

{ #category : #removing }
DataFrameTest >> testRemoveColumnsOfRowElementsSatisfingOnRowNamed [

	| expected aBlock |
	df := DataFrame withRows: #(
		(1 2 3)
   		(Dubai 4 5.0)
   		(nil 8.788 false)).
		
	df rowNames: #(A B C).
	df columnNames: #(X Y Z).
	
	expected := DataFrame withRows: #(
		(2)
   		(4)
   		(8.788)).
		
	expected rowNames: #(A B C).
	expected columnNames: #(Y).
	
	aBlock := [ :rowElement | rowElement ~= 4 ].
	
	self assert: (df removeColumnsOfRowElementsSatisfing: aBlock onRowNamed: 'B') equals: expected.
]

{ #category : #removing }
DataFrameTest >> testRemoveColumnsWithNilsAtRow [

	| expected |
	df := DataFrame withRows: #(
		(Barcelona 1.609 nil)
   		(Dubai nil nil)
   		(nil 8.788 false)).
		
	df rowNames: #(A B C).
	df columnNames: #(City Population BeenThere).
	
	expected := DataFrame withRows: #(
		(Barcelona)
   		(Dubai)
   		(nil)).
		
	expected rowNames: #(A B C).
	expected columnNames: #(City).
	
	self assert: (df removeColumnsWithNilsAtRow: 2) equals: expected.
]

{ #category : #removing }
DataFrameTest >> testRemoveColumnsWithNilsAtRowNamed [

	| expected |
	df := DataFrame withRows: #(
		(Barcelona 1.609 nil)
   		(Dubai nil nil)
   		(nil 8.788 false)).
		
	df rowNames: #(A B C).
	df columnNames: #(City Population BeenThere).
	
	expected := DataFrame withRows: #(
		(Barcelona)
   		(Dubai)
   		(nil)).
		
	expected rowNames: #(A B C).
	expected columnNames: #(City).
	
	self assert: (df removeColumnsWithNilsAtRowNamed: #B) equals: expected.
]

{ #category : #removing }
DataFrameTest >> testRemoveColumnsWithNilsAtRowOutOfRange [
	self should: [ df removeColumnsWithNilsAtRow: 100 ] raise: SubscriptOutOfBounds.
]

{ #category : #removing }
DataFrameTest >> testRemoveRow [

	| expected |
	
	expected := DataFrame withRows: #(
		(Barcelona 1.609 true)
   		(London 8.788 false)).
		
	expected rowNames: #(A C).
	expected columnNames: #(City Population BeenThere).
		
	df removeRow: #B.
	
	self assert: df equals: expected.
]

{ #category : #removing }
DataFrameTest >> testRemoveRowAt [

	| expected |
	
	expected := DataFrame withRows: #(
		(Barcelona 1.609 true)
   		(London 8.788 false)).
		
	expected rowNames: #(A C).
	expected columnNames: #(City Population BeenThere).
		
	df removeRowAt: 2.
	
	self assert: df equals: expected.
]

{ #category : #removing }
DataFrameTest >> testRemoveRowAtOutOfRange [
	self should: [ df removeRowAt: 100 ] raise: SubscriptOutOfBounds.
]

{ #category : #removing }
DataFrameTest >> testRemoveRowNotFound [
	self should: [ df removeRow: #NoSuchRow ] raise: LibrarySymbolNotFoundError.
]

{ #category : #removing }
DataFrameTest >> testRemoveRows [
	| expected |
	
	expected := DataFrame withRows: #(
		(Barcelona 1.609 true)).
		
	expected rowNames: #(A).
	expected columnNames: #(City Population BeenThere).
		
	df removeRows: #(B C).
	self assert: df equals: expected.
]

{ #category : #removing }
DataFrameTest >> testRemoveRowsAt [
	| expected |
	
	expected := DataFrame withRows: #(
		(Barcelona 1.609 true)).
		
	expected rowNames: #(A).
	expected columnNames: #(City Population BeenThere).
		
	df removeRowsAt: #(2 3).
	self assert: df equals: expected.
]

{ #category : #removing }
DataFrameTest >> testRemoveRowsOfColumnElementsSatisfingOnColumn [

	| expected aBlock |
	df := DataFrame withRows: #(
		(1 2 3)
   		(Dubai 4 5.0)
   		(nil 8.788 false)).
		
	df rowNames: #(A B C).
	df columnNames: #(X Y Z).
	
	expected := DataFrame withRows: #(
		(Dubai 4 5.0)).
		
	expected rowNames: #(B).
	expected columnNames: #(X Y Z).
	
	aBlock := [ :rowElement | rowElement ~= 4 ].
	
	self assert: (df removeRowsOfColumnElementsSatisfing: aBlock onColumn: 2) equals: expected.
]

{ #category : #removing }
DataFrameTest >> testRemoveRowsOfColumnElementsSatisfingOnColumnAllTrue [

	| expected aBlock |
	
	expected := DataFrame withColumns: #().	
	aBlock := [ :rowElement | true ].
	
	self assert: (df removeRowsOfColumnElementsSatisfing: aBlock onColumn: 2) equals: expected.
]

{ #category : #removing }
DataFrameTest >> testRemoveRowsOfColumnElementsSatisfingOnColumnNamed [

	| expected aBlock |
	df := DataFrame withRows: #(
		(1 2 3)
   		(Dubai 4 5.0)
   		(nil 8.788 false)).
		
	df rowNames: #(A B C).
	df columnNames: #(X Y Z).
	
	expected := DataFrame withRows: #(
		(Dubai 4 5.0)).
		
	expected rowNames: #(B).
	expected columnNames: #(X Y Z).
	
	aBlock := [ :rowElement | rowElement ~= 4 ].
	
	self assert: (df removeRowsOfColumnElementsSatisfing: aBlock onColumnNamed: #Y) equals: expected.
]

{ #category : #removing }
DataFrameTest >> testRemoveRowsWithNilsAtColumn [

	| expected |
	df := DataFrame withRows: #(
		(Barcelona 1.609 nil)
   		(Dubai nil nil)
   		(nil 8.788 false)).
		
	df rowNames: #(A B C).
	df columnNames: #(City Population BeenThere).
	
	expected := DataFrame withRows: #(
   		(nil 8.788 false)).
		
	expected rowNames: #(C).
	expected columnNames: #(City Population BeenThere).
	
	self assert: (df removeRowsWithNilsAtColumn: 3) equals: expected.
]

{ #category : #removing }
DataFrameTest >> testRemoveRowsWithNilsAtColumnNamed [

	| expected |
	df := DataFrame withRows: #(
		(Barcelona 1.609 nil)
   		(Dubai nil nil)
   		(nil 8.788 false)).
		
	df rowNames: #(A B C).
	df columnNames: #(City Population BeenThere).
	
	expected := DataFrame withRows: #(
   		(nil 8.788 false)).
		
	expected rowNames: #(C).
	expected columnNames: #(City Population BeenThere).
	
	self assert: (df removeRowsWithNilsAtColumnNamed: #BeenThere) equals: expected.
]

{ #category : #removing }
DataFrameTest >> testRemoveRowsWithNilsAtColumnOutOfRange [
	self should: [ df removeRowsWithNilsAtColumn: 100 ] raise: SubscriptOutOfBounds.
]

{ #category : #tests }
DataFrameTest >> testRenameColumnTo [
	| expected |
	expected := DataFrame
		withRows: #(
			(Barcelona 1.609 true)
   			(Dubai 2.789 true)
   			(London 8.788 false))
		rowNames: #(A B C)
		columnNames: #(City Population Visited).
		
	df renameColumn: #BeenThere to: #Visited.
	self assert: df equals: expected.
]

{ #category : #tests }
DataFrameTest >> testRenameColumnToNotFound [
	self
		should: [ df renameColumn: #NoSuchColumn to: #Sth ]
		raise: LibrarySymbolNotFoundError.
]

{ #category : #tests }
DataFrameTest >> testRenameRowTo [
	| expected |
	expected := DataFrame
		withRows: #(
			(Barcelona 1.609 true)
   			(Dubai 2.789 true)
   			(London 8.788 false))
		rowNames: #(A X C)
		columnNames: #(City Population BeenThere).
		
	df renameRow: #B to: #X.
	self assert: df equals: expected.
]

{ #category : #tests }
DataFrameTest >> testRenameRowToNotFound [
	self
		should: [ df renameRow: #NoSuchRow to: #Sth ]
		raise: LibrarySymbolNotFoundError.
]

{ #category : #splitjoin }
DataFrameTest >> testRightJoin [
	| df2 expected |
	
	df2 := DataFrame withRows: #(
		(false 0)
   		(false 1)
   		(true 2))
		rowNames: #(A B C)
		columnNames: #(Capital TimesVisited).
	
	expected := DataFrame withRows: #(
		(Barcelona 1.609 true false 0)
   		(Dubai 2.789 true false 1)
   		(London 8.788 false true 2))
		rowNames: #(A B C)
		columnNames: #(City Population BeenThere Capital TimesVisited).
	
	self assert: (df rightJoin: df2) equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testRightJoinNoIntersection [
	| df2 expected |
	
	df2 := DataFrame withRows: #(
		(false 0)
   		(false 1)
   		(true 2))
		rowNames: #(D E F)
		columnNames: #(Capital TimesVisited).
	
	expected := DataFrame withRows: #(
		(nil nil nil false 0)
   		(nil nil nil false 1)
   		(nil nil nil true 2))
		rowNames: #(D E F)
		columnNames: #(City Population BeenThere Capital TimesVisited).
	
	self assert: (df rightJoin: df2) equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testRightJoinOn [

	| df2 expected |
	
	df := DataFrame withRows: #(
		('K0' 'A0' 0)
		('K1' 'A1' 1)
		('K2' 'A2' 2)
		)
		rowNames: #('1K0' '1K1' '1K2')
		columnNames: #(Key A B).
	
	df2 := DataFrame withRows: #(
		('K0' 'B0' true)
		('K1' 'B1' false)
		('K2' 'B2' true)
		('K3' 'B3' false)
		)
		rowNames: #('1K0' '1K1' '1K2' '1K3')
		columnNames: #(Key C D).
	
	expected := DataFrame withRows: #(
		('K0' 'A0' 0 'B0' true)
		('K1' 'A1' 1 'B1' false)
		('K2' 'A2' 2 'B2' true)
		('K3' nil nil 'B3' false)
		)
		columnNames: #(Key A B C D).
		
	self assert: (df rightJoin: df2 on: 'Key') equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testRightJoinOnEmpty [
	| df2 expected |
	
	df2 := DataFrame new.
	
	expected := DataFrame withColumnNames: #(City Population BeenThere).
	
	self assert: (df rightJoin: df2) equals: expected.
	self assert: (df2 rightJoin: df) equals: df.
]

{ #category : #splitjoin }
DataFrameTest >> testRightJoinOnEmptyWithColumnNames [
	| df2 expected |
	
	df2 := DataFrame withColumnNames: #(Capital TimesVisited).
	
	expected := DataFrame withColumnNames: #(City Population BeenThere Capital TimesVisited).
	
	self assert: (df rightJoin: df2) equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testRightJoinOnLeftOnRight [

	| df2 expected |
	
	df := DataFrame withRows: #(
		('K0' 'A0' 0)
		('K1' 'A1' 1)
		('K2' 'A2' 2)
		)
		rowNames: #('1K0' '1K1' '1K2')
		columnNames: #(Key1 A B).
	
	df2 := DataFrame withRows: #(
		('K0' 'B0' true)
		('K1' 'B1' false)
		('K2' 'B2' true)
		('K3' 'B3' false)
		)
		rowNames: #('1K0' '1K1' '1K2' '1K3')
		columnNames: #(Key2 C D).
	
	expected := DataFrame withRows: #(
		('K0' 'A0' 0 'K0' 'B0' true)
		('K1' 'A1' 1 'K1' 'B1' false)
		('K2' 'A2' 2 'K2' 'B2' true)
		(nil nil nil 'K3' 'B3' false)
		)
		columnNames: #(Key1 A B Key2 C D).
		
	self assert: (df rightJoin: df2 onLeft: 'Key1' onRight: 'Key2') equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testRightJoinOnLeftOnRightDuplicateKeys [

	| df2 expected |
	
	df := DataFrame withRows: #(
		('K0' 'A0' 0)
		('K1' 'A1' 1)
		('K1' 'A2' 2)
		('K2' 'A3' 3)
		('K0' 'A4' 4)
		('K5' 'A5' 5)
		('K6' 'A6' 6)
		)
		rowNames: #('1K0' '1K1' '2K1' '1K2' '2K0' '1K5' '1K6')
		columnNames: #(Key A B).
	
	df2 := DataFrame withRows: #(
		('K3' 'B0' false)
		('K2' 'B1' true)
		('K2' 'B2' false)
		('K1' 'B3' true)
		('K3' 'B4' false)
		('K3' 'B5' true)
		('K0' 'B6' false)
		)
		rowNames: #('1K3' '1K2' '2K2' '1K1' '2K3' '3K3' '1K0')
		columnNames: #(Key C D).
	
	expected := DataFrame withRows: #(
		('K3' nil nil 'B0' false)
		('K2' 'A3' 3 'B1' true)
		('K2' 'A3' 3 'B2' false)
		('K1' 'A1' 1 'B3' true)
		('K1' 'A2' 2 'B3' true)
		('K3' nil nil 'B4' false)
		('K3' nil nil 'B5' true)
		('K0' 'A0' 0 'B6' false)
		('K0' 'A4' 4 'B6' false)
		)
		columnNames: #(Key A B C D).
		
	self assert: (df rightJoin: df2 onLeft: 'Key' onRight: 'Key') equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testRightJoinOnLeftOnRightMissingKey [

	| df2 |
	
	df := DataFrame withRows: #(
		('K0' 'A0' 0)
		('K1' 'A1' 1)
		('K2' 'A2' 2)
		)
		rowNames: #('1K0' '1K1' '1K2')
		columnNames: #(Key1 A B).
	
	df2 := DataFrame withRows: #(
		('K0' 'B0' true)
		('K1' 'B1' false)
		('K2' 'B2' true)
		('K3' 'B3' false)
		)
		rowNames: #('1K0' '1K1' '1K2' '1K3')
		columnNames: #(Key2 C D).
		
	self should: [df rightJoin: df2 onLeft: 'Key' onRight: 'Key2'] raise: Error.
	self should: [df rightJoin: df2 onLeft: 'Key1' onRight: 'Key'] raise: Error.
	self should: [df rightJoin: df2 onLeft: 'Key' onRight: 'Key'] raise: Error.
]

{ #category : #splitjoin }
DataFrameTest >> testRightJoinOnLeftOnRightNoIntersection [

	| df2 expected |
	
	df := DataFrame withRows: #(
		('K0' 'A0' 0)
		('K1' 'A1' 1)
		('K2' 'A2' 2)
		)
		rowNames: #('1K0' '1K1' '1K2')
		columnNames: #(Key A B).
	
	df2 := DataFrame withRows: #(
		('L0' 'B0' true)
		('L1' 'B1' false)
		('L2' 'B2' true)
		('L3' 'B3' false)
		)
		rowNames: #('1K0' '1K1' '1K2' '1K3')
		columnNames: #(Key C D).
	
	expected :=  DataFrame withRows: #(
		('L0' nil nil 'B0' true)
		('L1' nil nil 'B1' false)
		('L2' nil nil 'B2' true)
		('L3' nil nil 'B3' false)
		)
		columnNames: #(Key A B C D).
		
	self assert: (df rightJoin: df2 onLeft: 'Key' onRight: 'Key') equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testRightJoinOnLeftOnRightOnEmpty [

	| df2 |
	
	df := DataFrame withRows: #(
		('K0' 'A0' 0)
		('K1' 'A1' 1)
		('K2' 'A2' 2)
		)
		rowNames: #('1K0' '1K1' '1K2')
		columnNames: #(Key A B).
	
	df2 := DataFrame new.
		
	self should: [df rightJoin: df2 onLeft: 'Key' onRight: 'Key'] raise: Error.
]

{ #category : #splitjoin }
DataFrameTest >> testRightJoinOnLeftOnRightOnEmptyWithColumnNames [

	| df2 expected |
	
	df := DataFrame withRows: #(
		('K0' 'A0' 0)
		('K1' 'A1' 1)
		('K2' 'A2' 2)
		)
		rowNames: #('1K0' '1K1' '1K2')
		columnNames: #(Key A B).
	
	df2 := DataFrame withColumnNames: #(Key C D).
		
	expected := DataFrame withColumnNames: #(Key A B C D).
	self assert: (df rightJoin: df2 onLeft: 'Key' onRight: 'Key') equals: expected.
	
	expected := DataFrame withRows: #(
		('K0' nil nil 'A0' 0)
		('K1' nil nil 'A1' 1)
		('K2' nil nil 'A2' 2)
		)
		columnNames: #(Key C D A B).
	self assert: (df2 rightJoin: df onLeft: 'Key' onRight: 'Key') equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testRightJoinOnLeftOnRightOnSelf [
	
	| expected |
	
	df := DataFrame withRows: #(
		('K0' 'A0' 0)
		('K1' 'A1' 1)
		('K2' 'A2' 2)
		)
		rowNames: #('1K0' '1K1' '1K2')
		columnNames: #(Key A B).	
	
	expected := DataFrame withRows: #(
		('K0' 'A0' 0 'A0' 0)
		('K1' 'A1' 1 'A1' 1)
		('K2' 'A2' 2 'A2' 2)
		)
		columnNames: #(Key A_x B_x A_y B_y).
		
	self assert: (df rightJoin: df onLeft: 'Key' onRight: 'Key') equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testRightJoinOnLeftOnRightRowMismatch [

	| df2 expected |
	
	df := DataFrame withRows: #(
		('K0' 'A0' 0)
		('K3' 'A3' 3)
		('K2' 'A2' 2)
		)
		rowNames: #('1K0' '1K1' '1K2')
		columnNames: #(Key A B).
	
	df2 := DataFrame withRows: #(
		('K0' 'B0' true)
		('K1' 'B1' false)
		('K2' 'B2' true)
		('K3' 'B3' false)
		)
		rowNames: #('1K0' '1K1' '1K2' '1K3')
		columnNames: #(Key C D).
	
	expected := DataFrame withRows: #(
		('K0' 'A0' 0 'B0' true)
		('K1' nil nil 'B1' false)
		('K2' 'A2' 2 'B2' true)
		('K3' 'A3' 3 'B3' false)
		)
		columnNames: #(Key A B C D).
		
	self assert: (df rightJoin: df2 onLeft: 'Key' onRight: 'Key') equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testRightJoinOnLeftOnRightSameColumnNames [

	| df2 expected |
	
	df := DataFrame withRows: #(
		('K0' 'A0' 0)
		('K1' 'A1' 1)
		('K2' 'A2' 2)
		)
		rowNames: #('1K0' '1K1' '1K2')
		columnNames: #(Key A B).
	
	df2 := DataFrame withRows: #(
		('K0' 'B0' true)
		('K1' 'B1' false)
		('K2' 'B2' true)
		('K3' 'B3' false)
		)
		rowNames: #('1K0' '1K1' '1K2' '1K3')
		columnNames: #(Key A B).
	
	expected := DataFrame withRows: #(
		('K0' 'A0' 0 'B0' true)
		('K1' 'A1' 1 'B1' false)
		('K2' 'A2' 2 'B2' true)
		('K3' nil nil 'B3' false)
		)
		columnNames: #(Key A_x B_x A_y B_y).
		
	self assert: (df rightJoin: df2 onLeft: 'Key' onRight: 'Key') equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testRightJoinOnLeftOnRightSameKeyName [

	| df2 expected |
	
	df := DataFrame withRows: #(
		('K0' 'A0' 0)
		('K1' 'A1' 1)
		('K2' 'A2' 2)
		)
		rowNames: #('1K0' '1K1' '1K2')
		columnNames: #(Key A B).
	
	df2 := DataFrame withRows: #(
		('K0' 'B0' true)
		('K1' 'B1' false)
		('K2' 'B2' true)
		('K3' 'B3' false)
		)
		rowNames: #('1K0' '1K1' '1K2' '1K3')
		columnNames: #(Key C D).
	
	expected := DataFrame withRows: #(
		('K0' 'A0' 0 'B0' true)
		('K1' 'A1' 1 'B1' false)
		('K2' 'A2' 2 'B2' true)
		('K3' nil nil 'B3' false)
		)
		columnNames: #(Key A B C D).
		
	self assert: (df rightJoin: df2 onLeft: 'Key' onRight: 'Key') equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testRightJoinOnSelf [
	| expected |
	
	expected := DataFrame withRows: #(
		(Barcelona 1.609 true Barcelona 1.609 true)
   		(Dubai 2.789 true Dubai 2.789 true)
   		(London 8.788 false London 8.788 false))
		rowNames: #(A B C)
		columnNames: #(City_x Population_x BeenThere_x City_y Population_y BeenThere_y).
	
	self assert: (df rightJoin: df) equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testRightJoinRowMismatch [
	| df2 expected |
	
	df2 := DataFrame withRows: #(
		(false 0)
   		(false 1)
   		(true 2))
		rowNames: #(A D C)
		columnNames: #(Capital TimesVisited).
	
	expected := DataFrame withRows: #(
		(Barcelona 1.609 true false 0)
   		(nil nil nil false 1)
   		(London 8.788 false true 2))
		rowNames: #(A D C)
		columnNames: #(City Population BeenThere Capital TimesVisited).
	
	self assert: (df rightJoin: df2) equals: expected.
]

{ #category : #splitjoin }
DataFrameTest >> testRightJoinSameColumnNames [
	| df2 expected |
	
	df2 := DataFrame withRows: #(
		(false 0)
   		(false 1)
   		(true 2))
		rowNames: #(A D C)
		columnNames: #(Capital Population).
	
	expected := DataFrame withRows: #(
		(Barcelona 1.609 true false 0)
   		(nil nil nil false 1)
   		(London 8.788 false true 2))
		rowNames: #(A D C)
		columnNames: #(City Population_x BeenThere Capital Population_y).
	
	self assert: (df rightJoin: df2) equals: expected.
]

{ #category : #tests }
DataFrameTest >> testRow [

	| actualSeries expectedSeries |

	expectedSeries := DataSeries withValues:
		#('Dubai' 2.789 true).
		
	expectedSeries name: #B.
	expectedSeries keys: df columnNames.
	
	actualSeries := df row: #B.
	
	self assert: actualSeries equals: expectedSeries.
]

{ #category : #tests }
DataFrameTest >> testRowAt [

	| actualSeries expectedSeries |

	expectedSeries := DataSeries withValues:
		#('Dubai' 2.789 true).
		
	expectedSeries name: #B.
	expectedSeries keys: df columnNames.
	
	actualSeries := df rowAt: 2.
	
	self assert: actualSeries equals: expectedSeries.
]

{ #category : #tests }
DataFrameTest >> testRowAtPut [

	| actual expected |

	expected := DataFrame withRows: #(
		(Barcelona 1.609 true)
   		(X Y Z)
   		(London 8.788 false)).
		
	expected rowNames: #(A B C).
	expected columnNames: #(City Population BeenThere).
	
	actual := df.
	actual rowAt: 2 put: #(X Y Z).
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataFrameTest >> testRowAtTransform [

	| expected |

	expected := DataFrame
		withRows: #(
			(Barcelona 1.609 true)
   			(Dubai 0 true)
   			(London 8.788 false))
		rowNames: #(A B C)
		columnNames: #(City Population BeenThere).
		
	df rowAt: 2 transform: [ :row | row at: #Population put: 0; yourself ].
	self assert: df equals: expected
]

{ #category : #tests }
DataFrameTest >> testRowIfAbsent [

	| exceptionBlockEvaluated |
	
	exceptionBlockEvaluated := false.

	df row: #NoSuchRow
		ifAbsent: [ exceptionBlockEvaluated := true ].
		
	self assert: exceptionBlockEvaluated.
]

{ #category : #tests }
DataFrameTest >> testRowNames [
	| newNames |
	newNames := #(X Y Z).
	df rowNames: newNames.
	self assert: df rowNames equals: newNames asOrderedCollection
]

{ #category : #tests }
DataFrameTest >> testRowNamesMustBeDistinct [
	| newNames |
	newNames := #(x y y).
	self should: [ df rowNames: newNames ] raise: Error.
]

{ #category : #tests }
DataFrameTest >> testRowNamesSizeMismatch [
	| tooManyNames notEnoughNames |
	
	tooManyNames := #(W X Y Z).
	notEnoughNames := #(Y Z).
	
	self should: [ df rowNames: tooManyNames ] raise: SizeMismatch.
	self should: [ df rowNames: notEnoughNames ] raise: SizeMismatch.
]

{ #category : #tests }
DataFrameTest >> testRowNotFound [
	self
		should: [ df row: #NoSuchRow ]
		raise: LibrarySymbolNotFoundError.
]

{ #category : #tests }
DataFrameTest >> testRowPut [

	| actual expected |

	expected := DataFrame withRows: #(
		(Barcelona 1.609 true)
   		(X Y Z)
   		(London 8.788 false)).
		
	expected rowNames: #(A B C).
	expected columnNames: #(City Population BeenThere).
	
	actual := df.
	actual row: #B put: #(X Y Z).
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataFrameTest >> testRowPutIfAbsent [

	| expected exceptionBlockEvaluated |
	
	exceptionBlockEvaluated := false.
	
	expected := DataFrame
		withRows: #(
			(Barcelona 1.609 true)
   			(Dubai 2.789 true)
   			(London 8.788 false))
		rowNames: #(A B C)
		columnNames: #(City Population BeenThere).
	
	df row: #NoSuchRow
		put: #(0 0 0)
		ifAbsent: [ exceptionBlockEvaluated := true ].
		
	self assert: df equals: expected.
	self assert: exceptionBlockEvaluated.
]

{ #category : #tests }
DataFrameTest >> testRowPutNotFound [
	self
		should: [ df row: #NoSuchRow put: #(0 0 0) ]
		raise: LibrarySymbolNotFoundError.
]

{ #category : #tests }
DataFrameTest >> testRowTransform [

	| expected |

	expected := DataFrame
		withRows: #(
			(Barcelona 1.609 true)
   			(Dubai 0 true)
   			(London 8.788 false))
		rowNames: #(A B C)
		columnNames: #(City Population BeenThere).
		
	df row: #B transform: [ :row | row at: #Population put: 0; yourself ].
	self assert: df equals: expected
]

{ #category : #tests }
DataFrameTest >> testRowTransformIfAbsent [

	| expected exceptionBlockEvaluated |

	exceptionBlockEvaluated := false.
	
	expected := DataFrame
		withRows: #(
			(Barcelona 1.609 true)
   			(Dubai 2.789 true)
   			(London 8.788 false))
		rowNames: #(A B C)
		columnNames: #(City Population BeenThere).
		
	df row: #NoSuchRow
		transform: [ :row | row at: #Population put: 0 ]
		ifAbsent: [ exceptionBlockEvaluated := true ].
		
	self assert: df equals: expected.
	self assert: exceptionBlockEvaluated.
]

{ #category : #tests }
DataFrameTest >> testRowTransformNotFound [

	| expected |
	
	expected := DataFrame
		withRows: #(
			(Barcelona 1.609 true)
   			(Dubai 2.789 true)
   			(London 8.788 false))
		rowNames: #(A B C)
		columnNames: #(City Population BeenThere).
		
	self
		should: [
			df row: #NoSuchRow
				transform: [ :row | row at: #Population put: 0 ] ]
		raise: LibrarySymbolNotFoundError.
		
	self assert: df equals: expected.
]

{ #category : #tests }
DataFrameTest >> testRows [

	| rowNames actualDataFrame expectedDataFrame |
	
	rowNames := #(A C).
	
	expectedDataFrame := DataFrame withRows: #(
		(Barcelona 1.609 true)
   		(London 8.788 false)).
		
	expectedDataFrame rowNames: rowNames.
	expectedDataFrame columnNames: df columnNames.
	
	actualDataFrame := df rows: rowNames.
	
	self assert: actualDataFrame equals: expectedDataFrame.
]

{ #category : #tests }
DataFrameTest >> testRowsAt [

	| rowNumbers actualDataFrame expectedDataFrame |
	
	rowNumbers := #(1 3).
	
	expectedDataFrame := DataFrame withRows: #(
		(Barcelona 1.609 true)
   		(London 8.788 false)).
		
	expectedDataFrame rowNames:
		(rowNumbers collect: [ :i |
			df rowNames at: i ]).
	expectedDataFrame columnNames: df columnNames.
	
	actualDataFrame := df rowsAt: rowNumbers.
	
	self assert: actualDataFrame equals: expectedDataFrame.
]

{ #category : #tests }
DataFrameTest >> testRowsAtPut [
	| rowNames columnNames dataFrame newRows expected |
	
	rowNames := #('01:10' '01:30' '01:50' '02:10' '02:30') collect: #asTime.
	columnNames := #(temperature precipitation type).
	
	dataFrame := DataFrame
		withRows: #(
			(2.4 true rain)
			(0.5 true rain)
			(-1.2 true snow)
			(-2.3 false -)
			(3.2 true rain))
		rowNames: rowNames
		columnNames: columnNames.
		
	newRows := #(
		(1 1 1)
		(2 2 2)
		(3 3 3)).
		
	expected := DataFrame
		withRows: #(
			(2.4 true rain)
			(3 3 3)
			(1 1 1)
			(-2.3 false -)
			(2 2 2))
		rowNames: rowNames
		columnNames: columnNames.
	
	dataFrame rowsAt: #(3 5 2) put: newRows.
	self assert: dataFrame equals: expected.
]

{ #category : #tests }
DataFrameTest >> testRowsFromTo [

	| actualDataFrame expectedDataFrame |
		
	expectedDataFrame := DataFrame withRows: #(
   		(Dubai 2.789 true)
   		(London 8.788 false)).
		
	expectedDataFrame rowNames: #(B C).
	expectedDataFrame columnNames: df columnNames.
	
	actualDataFrame := df rowsFrom: 2 to: 3.
	
	self assert: actualDataFrame equals: expectedDataFrame.
]

{ #category : #tests }
DataFrameTest >> testRowsFromToPut [
	| rowNames columnNames dataFrame newRows expected |
	
	rowNames := #('01:10' '01:30' '01:50' '02:10' '02:30') collect: #asTime.
	columnNames := #(temperature precipitation type).
	
	dataFrame := DataFrame
		withRows: #(
			(2.4 true rain)
			(0.5 true rain)
			(-1.2 true snow)
			(-2.3 false -)
			(3.2 true rain))
		rowNames: rowNames
		columnNames: columnNames.
		
	newRows := #(
		(1 1 1)
		(2 2 2)
		(3 3 3)).
		
	expected := DataFrame
		withRows: #(
			(2.4 true rain)
			(3 3 3)
			(2 2 2)
			(1 1 1)
			(3.2 true rain))
		rowNames: rowNames
		columnNames: columnNames.
	
	dataFrame rowsFrom: 4 to: 2 put: newRows.
	self assert: dataFrame equals: expected.
]

{ #category : #tests }
DataFrameTest >> testRowsPut [
	| rowNames columnNames dataFrame newRows expected |
	
	rowNames := #('01:10' '01:30' '01:50' '02:10' '02:30') collect: #asTime.
	columnNames := #(temperature precipitation type).
	
	dataFrame := DataFrame
		withRows: #(
			(2.4 true rain)
			(0.5 true rain)
			(-1.2 true snow)
			(-2.3 false -)
			(3.2 true rain))
		rowNames: rowNames
		columnNames: columnNames.
		
	newRows := #(
		(1 1 1)
		(2 2 2)
		(3 3 3)).
		
	expected := DataFrame
		withRows: #(
			(2.4 true rain)
			(3 3 3)
			(1 1 1)
			(-2.3 false -)
			(2 2 2))
		rowNames: rowNames
		columnNames: columnNames.
	
	dataFrame rows: { '01:50' asTime . '02:30' asTime . '01:30' asTime } put: newRows.
	self assert: dataFrame equals: expected.
]

{ #category : #tests }
DataFrameTest >> testSelect [
	| actual expected |

	expected := DataFrame
		withRows: #(
			(Dubai 2.789 true)
			(London 8.788 false))
		rowNames: #(B C)
		columnNames: df columnNames.
		
	actual := df select:
		[ :row | (row at: #Population) > 2 ].
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataFrameTest >> testSelectEmptyDataFrame [
	| actual expected |

	expected := DataFrame withRows: #().
		
	actual := df select:
		[ :row | (row at: #Population) > 10 ].
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataFrameTest >> testSortBy [

	| actual expected |

	expected := DataFrame withRows: #(
		(Barcelona 1.609 true)
   		(Dubai 2.789 true)
		(London 8.788 false)).
		
	expected rowNames: #(A B C).
	expected columnNames: #(City Population BeenThere).
	
	actual := df sortBy: #Population.
	self assert: actual equals: expected.
]

{ #category : #tests }
DataFrameTest >> testSortByUsing [
	"Sort by second letter of city name"
	| actual expected |

	expected := DataFrame withRows: #(
		(Barcelona 1.609 true)
		(London 8.788 false)
		(Dubai 2.789 true)).
		
	expected rowNames: #(A C B).
	expected columnNames: #(City Population BeenThere).
	
	actual := df sortBy: #City using: [ :name1 :name2 |
		name1 second <= name2 second ].
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataFrameTest >> testSortDescendingBy [

	| actual expected |

	expected := DataFrame withRows: #(
		(London 8.788 false)
		(Dubai 2.789 true)
		(Barcelona 1.609 true)).
		
	expected rowNames: #(C B A).
	expected columnNames: #(City Population BeenThere).
	
	actual := df sortDescendingBy: #Population.
	self assert: actual equals: expected.
]

{ #category : #tests }
DataFrameTest >> testToColumnApplyElementwise [

	| expected |
	
	expected := DataFrame withRows: #(
		(Barcelona '1.609' true)
   		(Dubai '2.789' true)
   		(London '8.788' false)).
		
	expected rowNames: #(A B C).
	expected columnNames: #(City Population BeenThere).
		
	df toColumn: #Population
		applyElementwise: [ :each | each asString ].
	
	self assert: df equals: expected.
]

{ #category : #tests }
DataFrameTest >> testToColumnAtApplyElementwise [

	| expected |
	
	expected := DataFrame withRows: #(
		(Barcelona '1.609' true)
   		(Dubai '2.789' true)
   		(London '8.788' false)).
		
	expected rowNames: #(A B C).
	expected columnNames: #(City Population BeenThere).
		
	df toColumnAt: 2
		applyElementwise: [ :each | each asString ].
	
	self assert: df equals: expected.
]

{ #category : #tests }
DataFrameTest >> testToColumnsApplyElementwise [

	| expected |
	
	expected := DataFrame withRows: #(
		(Barcelona '1.609' 'true')
   		(Dubai '2.789' 'true')
   		(London '8.788' 'false')).
		
	expected rowNames: #(A B C).
	expected columnNames: #(City Population BeenThere).
		
	df toColumns: #(Population BeenThere)
		applyElementwise: [ :each | each asString ].
	
	self assert: df equals: expected.
]

{ #category : #tests }
DataFrameTest >> testToColumnsAtApplyElementwise [

	| expected |
	
	expected := DataFrame withRows: #(
		(Barcelona '1.609' 'true')
   		(Dubai '2.789' 'true')
   		(London '8.788' 'false')).
		
	expected rowNames: #(A B C).
	expected columnNames: #(City Population BeenThere).
		
	df toColumnsAt: #(2 3)
		applyElementwise: [ :each | each asString ].
	
	self assert: df equals: expected.
]

{ #category : #tests }
DataFrameTest >> testTransposed [

	| expected |
	
	expected := DataFrame withRows: #(
		('Barcelona' 'Dubai' 'London')
		(1.609 2.789 8.788)
   		(true true false)).
		
	expected rowNames: df columnNames.
	expected columnNames: df rowNames.
	
	self assert: df transposed equals: expected.
	

]

{ #category : #tests }
DataFrameTest >> testVarSizeInstanceCreation [

	| dataFrame |
	dataFrame := DataFrame new: 3@2.
	
	self assert: dataFrame numberOfRows equals: 3.
	self assert: dataFrame numberOfColumns equals: 2.
	
	self assert: dataFrame rowNames equals: #(1 2 3) asOrderedCollection.
	self assert: dataFrame columnNames equals: #(1 2) asOrderedCollection.
]

{ #category : #tests }
DataFrameTest >> testWithColumnsRowNames [
	| dataframe |
	dataframe := DataFrame
		withColumns: #(#(1 2 3) #(4 5 6))
		rowNames: #('one' 'two' 'three').
	self
		assert: dataframe rowNames asArray
		equals: #('one' 'two' 'three').
	self assert: (dataframe row: 'one') asArray equals: #(1 4).
	self assert: (dataframe row: 'two') asArray equals: #(2 5).
	self assert: (dataframe row: 'three') asArray equals: #(3 6)
]

{ #category : #tests }
DataFrameTest >> testWithColumnsRowNamesColumnNames [
	| dataframe |
	dataframe := DataFrame
		withColumns: #(#(1 4) #(2 5) #(3 6))
		rowNames: #('1' '2')
		columnNames: #('one' 'two' 'three').
	self
		assert: dataframe columnNames asArray
		equals: #('one' 'two' 'three').
	self assert: ((dataframe column: 'one') at: '1') equals: 1.
	self assert: ((dataframe column: 'two') at: '1') equals: 2.
	self assert: ((dataframe column: 'three') at: '1') equals: 3.
	self assert: ((dataframe column: 'one') at: '2') equals: 4.
	self assert: ((dataframe column: 'two') at: '2') equals: 5.
	self assert: ((dataframe column: 'three') at: '2') equals: 6
]

{ #category : #tests }
DataFrameTest >> testWithColumnsRowNamesColumnNames_emptyColumns [
	| dataframe |
	dataframe := DataFrame
		withColumns: #()
		rowNames: #('1' '2')
		columnNames: #().
	self assert: dataframe rowNames asArray equals: #('1' '2').
	self assert: (dataframe row: '1') isEmpty.
	self assert: (dataframe row: '2') isEmpty
]

{ #category : #tests }
DataFrameTest >> testWithColumnsRowNames_emptyColumns [
	| dataframe |
	dataframe := DataFrame
		withColumns: #()
		rowNames: #('one' 'two' 'three').
	self
		assert: dataframe rowNames asArray
		equals: #('one' 'two' 'three').
	self assert: (dataframe row: 'one') isEmpty
]

{ #category : #tests }
DataFrameTest >> testWithIndexCollect [
	| expectedDf expectedResult actualResult |
	
	expectedDf := DataFrame withRows: #(
		(Barcelona 1.609 true)
   		(Dubai 2.789 true)
   		(London 8.788 false)).
		
	expectedDf rowNames: #(A B C).
	expectedDf columnNames: #(City Population BeenThere).
	
	expectedResult := DataFrame withRows: #(
		('BARCELONA' 2)
   		('DUBAI' 4)
   		('LONDON' 11)).
		
	expectedResult rowNames: #(A B C).
	expectedResult columnNames: #(City Population).
	
	actualResult := df withIndexCollect: [ :row :index |
		row at: #City put: (row at: #City) asUppercase.
		row at: #Population put: (row at: #Population) asInteger + index.
		row removeAt: #BeenThere.
		row ].
	
	self assert: actualResult equals: expectedResult.
	self assert: df equals: expectedDf.
]

{ #category : #tests }
DataFrameTest >> testWithIndexDo [

	| actual expected |

	expected := { 
		1 -> (DataSeries withKeys: df columnNames values: #(Barcelona 1.609 true) name: 'A') .
		2 -> (DataSeries withKeys: df columnNames values: #(Dubai 2.789 true) name: 'B') .
		3 -> (DataSeries withKeys: df columnNames values: #(London 8.788 false) name: 'C') } asDictionary.
		
	actual := Dictionary new.
	
	df withIndexDo: [ :each :index |
		actual at: index put: each ].
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataFrameTest >> testWithIndexDoCanModifyRows [
	| expected |

	expected := DataFrame
		withRows: #(
			(Barcelona 1.609 true)
			(Dubai 4.789 true)
			(London 11.788 false))
		rowNames: df rowNames
		columnNames: df columnNames.
	
	df withIndexDo: [ :row :index |
		row name = 'A'
			ifFalse: [ row at: #Population put: ((row at: #Population) + index) ] ].
	
	self assert: df equals: expected.
]

{ #category : #tests }
DataFrameTest >> testWithIndexReject [
	| actual expected |

	expected := DataFrame
		withRows: #(
			(Barcelona 1.609 true)
			(London 8.788 false))
		rowNames: #(A C)
		columnNames: df columnNames.
		
	actual := df withIndexReject: [ :row :index |
		((row at: #Population) > 2) and: [ index % 2 = 0 ] ].
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataFrameTest >> testWithIndexSelect [
	| actual expected |

	expected := DataFrame
		withRows: #(
			(Dubai 2.789 true))
		rowNames: #(B)
		columnNames: df columnNames.
		
	actual := df withIndexSelect: [ :row :index |
		((row at: #Population) > 2) and: [ index % 2 = 0 ] ].
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataFrameTest >> testWithRowsColumnNames [
	| dataframe |
	dataframe := DataFrame
		withRows: #(#(1 2 3) #(4 5 6))
		columnNames: #('one' 'two' 'three').
	self
		assert: dataframe columnNames asArray
		equals: #('one' 'two' 'three').
	self assert: (dataframe column: 'one') asArray equals: #(1 4).
	self assert: (dataframe column: 'two') asArray equals: #(2 5).
	self assert: (dataframe column: 'three') asArray equals: #(3 6)
]

{ #category : #tests }
DataFrameTest >> testWithRowsColumnNames_emptyRows [
	| dataframe |
	dataframe := DataFrame
		withRows: #()
		columnNames: #('one' 'two' 'three').
	self
		assert: dataframe columnNames asArray
		equals: #('one' 'two' 'three').
	self assert: (dataframe column: 'one') isEmpty
]

{ #category : #tests }
DataFrameTest >> testWithRowsRowNamesColumnNames [
	| dataframe |
	dataframe := DataFrame
		withRows: #(#(1 2 3) #(4 5 6))
		rowNames: #('1' '2')
		columnNames: #('one' 'two' 'three').
	self
		assert: dataframe columnNames asArray
		equals: #('one' 'two' 'three').
	self assert: ((dataframe column: 'one') at: '1') equals: 1.
	self assert: ((dataframe column: 'two') at: '1') equals: 2.
	self assert: ((dataframe column: 'three') at: '1') equals: 3.
	self assert: ((dataframe column: 'one') at: '2') equals: 4.
	self assert: ((dataframe column: 'two') at: '2') equals: 5.
	self assert: ((dataframe column: 'three') at: '2') equals: 6
]

{ #category : #tests }
DataFrameTest >> testWithRowsRowNamesColumnNames_emptyRows [
	| dataframe |
	dataframe := DataFrame
		withRows: #()
		rowNames: #()
		columnNames: #('one' 'two' 'three').
	self
		assert: dataframe columnNames asArray
		equals: #('one' 'two' 'three').
	self assert: (dataframe column: 'one') isEmpty
]
