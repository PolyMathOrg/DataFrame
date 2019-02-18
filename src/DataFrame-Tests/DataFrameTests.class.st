Class {
	#name : #DataFrameTests,
	#superclass : #TestCase,
	#instVars : [
		'df'
	],
	#category : 'DataFrame-Tests'
}

{ #category : #initialization }
DataFrameTests >> setUp [

	df := DataFrame fromRows: #(
		('Barcelona' 1.609 true)
   		('Dubai' 2.789 true)
   		('London' 8.788 false)).
		
	df rowNames: #(A B C).
	df columnNames: #(City Population BeenThere).
]

{ #category : #tests }
DataFrameTests >> testAddEmptyColumnNamed [

	| expected |
	
	expected := DataFrame fromRows: #(
		('Barcelona' 1.609 true nil)
   		('Dubai' 2.789 true nil)
   		('London' 8.788 false nil)).
		
	expected rowNames: #(A B C).
	expected columnNames: #(City Population BeenThere EmptyColumn).
		
	df addEmptyColumnNamed: #EmptyColumn.
	
	self assert: df equals: expected.
]

{ #category : #tests }
DataFrameTests >> testAddRow [

	| expected |
	
	expected := DataFrame fromRows: #(
		('Barcelona' 1.609 true)
   		('Dubai' 2.789 true)
   		('London' 8.788 false)
		('Lviv' 0.724 true)).
		
	expected rowNames: #(A B C D).
	expected columnNames: #(City Population BeenThere).
		
	df addRow: #('Lviv' 0.724 true) named: #D.
	
	self assert: df equals: expected.
]

{ #category : #tests }
DataFrameTests >> testAddRowSizeMismatch [

	| aBlock |
	aBlock := [ df addRow: #(1 2) named: #TooSmall ].
	
	self should: aBlock raise: SizeMismatch.
]

{ #category : #tests }
DataFrameTests >> testAsArrayOfColumns [

	| expected |
	
	expected := #(
		('Barcelona' 'Dubai' 'London')
		(1.609 2.789 8.788)
   		(true true false)).
	
	self assert: df asArrayOfColumns equals: expected.
	

]

{ #category : #tests }
DataFrameTests >> testAsArrayOfRows [

	| expected |
	
	expected := {
		#('Barcelona' 1.609 true) asDataSeries name: 'A'; keys: df columnNames; yourself .
   		#('Dubai' 2.789 true) asDataSeries name: 'B'; keys: df columnNames; yourself .
   		#('London' 8.788 false) asDataSeries name: 'C'; keys: df columnNames; yourself
	}.
	
	self assert: df asArrayOfRows equals: expected.
	

]

{ #category : #tests }
DataFrameTests >> testAsStringTable [

	| expected actual |
	
	expected := String new writeStream.
	expected
		nextPutAll: '   |  City       Population  BeenThere  '; cr;
		nextPutAll: '---+------------------------------------'; cr;
		nextPutAll: 'A  |  Barcelona       1.609       true  '; cr;
    	nextPutAll: 'B  |  Dubai           2.789       true  '; cr;
		nextPutAll: 'C  |  London          8.788      false  '; cr.
	
	expected := expected contents.
	actual := df asStringTable.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataFrameTests >> testAt [

	| actual expected |

	expected := DataSeries fromArray:
		#('Dubai' 2.789 true).
		
	expected name: #B.
	expected keys: df columnNames.
	
	actual := df at: 2.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataFrameTests >> testAtAt [

	self assert: (df at: 2 at: 1) equals: 'Dubai'.
]

{ #category : #tests }
DataFrameTests >> testAtAtPut [

	| expectedDataFrame |
	
	expectedDataFrame := DataFrame fromRows: #(
		('Barcelona' 1.609 true)
   		('Dubai' 2.789 true)
   		('London' 1000 false)).
		
	expectedDataFrame rowNames: df rowNames.
	expectedDataFrame columnNames: df columnNames.
		
	df at: 3 at: 2 put: 1000.
			
	self assert: df equals: expectedDataFrame. 
]

{ #category : #tests }
DataFrameTests >> testAtColumnPut [

	| expected |
	
	expected := DataFrame fromRows: #(
		('Barcelona' 1.609 true 4)
   		('Dubai' 2.789 true 3)
   		('London' 8.788 false 4)).
		
	expected rowNames: #(A B C).
	expected columnNames: #(City Population BeenThere Rating).
		
	df atColumn: #Rating put: #(4 3 4).
	
	self assert: df equals: expected.
]

{ #category : #tests }
DataFrameTests >> testAtColumnPutSizeMismatch [

	| aBlock |
	aBlock := [ df atColumn: #TooBig put: #(1 2 3 4) ].
	
	self should: aBlock raise: SizeMismatch.
]

{ #category : #tests }
DataFrameTests >> testCategoricalColumns [

	self
		assert: df categoricalColumns
		equals: #(City BeenThere).
]

{ #category : #tests }
DataFrameTests >> testColumn [

	| actualSeries expectedSeries |

	expectedSeries := DataSeries fromArray:
		#('Barcelona' 'Dubai' 'London').
	
	expectedSeries name: #City.
	expectedSeries keys: df rowNames.
	
	actualSeries := df column: #City.
	
	self assert: actualSeries equals: expectedSeries.
]

{ #category : #tests }
DataFrameTests >> testColumnAt [

	| actualSeries expectedSeries |

	expectedSeries := DataSeries fromArray:
		#('Barcelona' 'Dubai' 'London').
	
	expectedSeries name: #City.
	expectedSeries keys: df rowNames.
	
	actualSeries := df columnAt: 1.
	
	self assert: actualSeries equals: expectedSeries.
]

{ #category : #tests }
DataFrameTests >> testColumnAtPut [

	| actual expected |

	expected := DataFrame fromRows: #(
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
DataFrameTests >> testColumnPut [

	| actual expected |

	expected := DataFrame fromRows: #(
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
DataFrameTests >> testColumnTypes [

	| expected actual |

	"Note: 0.1 class will be BoxFloat64 on Pharo32 and SmallFloat64 on Pharo64"
	expected := { ByteString . 0.1 class . Boolean }.
	actual := df columnTypes.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataFrameTests >> testColumns [

	| columnNames actualDataFrame expectedDataFrame |
	
	columnNames := #(City BeenThere).
	
	expectedDataFrame := DataFrame fromRows: #(
		('Barcelona' true)
   		('Dubai' true)
   		('London' false)).
		
	expectedDataFrame rowNames: df rowNames.
	expectedDataFrame columnNames: columnNames.
	
	actualDataFrame := df columns: columnNames.
	
	self assert: actualDataFrame equals: expectedDataFrame.
]

{ #category : #tests }
DataFrameTests >> testColumnsAt [

	| columnNumbers actualDataFrame expectedDataFrame |
	
	columnNumbers := #(1 3).
	
	expectedDataFrame := DataFrame fromRows: #(
		('Barcelona' true)
   		('Dubai' true)
   		('London' false)).
		
	expectedDataFrame rowNames: df rowNames.
	expectedDataFrame columnNames:
		(columnNumbers collect: [ :i |
			df columnNames at: i ]).
	
	actualDataFrame := df columnsAt: columnNumbers.
	
	self assert: actualDataFrame equals: expectedDataFrame.
]

{ #category : #tests }
DataFrameTests >> testColumnsFromTo [

	| actualDataFrame expectedDataFrame |
		
	expectedDataFrame := DataFrame fromRows: #(
		(1.609 true)
   		(2.789 true)
   		(8.788 false)).
		
	expectedDataFrame rowNames: df rowNames.
	expectedDataFrame columnNames: #(Population BeenThere).
	
	actualDataFrame := df columnsFrom: 2 to: 3.
	
	self assert: actualDataFrame equals: expectedDataFrame.
]

{ #category : #tests }
DataFrameTests >> testCreateDataFrameWith3ColumnsAndNoRows [
	| dataFrame |
	dataFrame := DataFrame new: 0@3.
	
	self assert: dataFrame class equals: DataFrame.
	self assert: dataFrame dimensions equals: 0@3.
	self assert: dataFrame rowNames equals: #().
	self assert: dataFrame columnNames equals: #(1 2 3).
]

{ #category : #tests }
DataFrameTests >> testCreateEmptyDataFrame [
	| dataFrame |
	dataFrame := DataFrame new.
	
	self assert: dataFrame class equals: DataFrame.
	self assert: dataFrame dimensions equals: 0@0.
	self assert: dataFrame rowNames equals: #().
	self assert: dataFrame columnNames equals: #().
]

{ #category : #tests }
DataFrameTests >> testCreateEmptyDataFrameWithColumnNames [
	| columns dataFrame |
	
	columns := #(Name Age Nationality).
	dataFrame := DataFrame emptyWithColumnNames: columns.
	
	self assert: dataFrame class equals: DataFrame.
	self assert: dataFrame dimensions equals: 0@3.
	self assert: dataFrame rowNames equals: #().
	self assert: dataFrame columnNames equals: columns.
]

{ #category : #tests }
DataFrameTests >> testCrossTabulation [

	| dataFrame expected |
	
	dataFrame := DataFrame fromRows: #(
		(Male Young)
		(Female Old)
		(Female Young)
		(Female Young)
		(Male Old)).
	dataFrame columnNames: #(Gender Age).
	
	expected := DataFrame fromRows:
		#((1 1)(2 1)).
		
	expected rowNames: #(Male Female).
	expected columnNames: #(Young Old).	
	
	self assert: (dataFrame crossTabulate: #Gender with: #Age) equals: expected.
]

{ #category : #tests }
DataFrameTests >> testDo [

	| actual expected |

	expected := LinkedList
		with: #('Barcelona' 1.609 true) asDataSeries
		with: #('Dubai' 2.789 true) asDataSeries
		with: #('London' 8.788 false) asDataSeries.
		
	expected doWithIndex: [ :each :i |
		each keys: #(City Population BeenThere).
		each name: (#(A B C) at: i) ].
		
	actual := LinkedList new.
	
	df do: [ :each |
		actual add: each ].
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataFrameTests >> testEquality [

	| df1 df2 |
	
	df1 := DataFrame fromRows: #((1 2)(3 4)).
	df2 := DataFrame fromRows: #((1 2)(3 4)).
	
	self assert: df1 equals: df2.
	self assert: (df1 = df2).
]

{ #category : #tests }
DataFrameTests >> testFromColumns [

	| columns df expectedValues |
	
	columns := #(
		('Robb Stark' 'Jon Snow' 'Eddard Stark')
    	(3 4 1)
      	(true false true)).
	
	df := DataFrame fromColumns: columns.
	
	self assert: df rowNames equals: #(1 2 3).
	self assert: df columnNames equals: #(1 2 3).
	
	"We know that it works, because we have tests for it in DataFrameInternalTests"
	expectedValues := DataFrameInternal fromColumns: columns.
	
	self assert: df contents equals: expectedValues.
]

{ #category : #tests }
DataFrameTests >> testFromMatrix [

	| matrix df expectedValues |
	
	matrix := Matrix
		rows: 3 columns: 3
		contents: #(
			'Robb Stark' 3 true
    		'Jon Snow' 4 false
      		'Eddard Stark' 1 true).
	
	df := DataFrame fromMatrix: matrix.
	
	self assert: df rowNames equals: #(1 2 3).
	self assert: df columnNames equals: #(1 2 3).
	
	"We know that it works, because we have tests for it in DataFrameInternalTests"
	expectedValues := DataFrameInternal fromMatrix: matrix.
	
	self assert: df contents equals: expectedValues.
]

{ #category : #tests }
DataFrameTests >> testFromRows [

	| rows df expectedValues |
	
	rows := #(
		('Robb Stark' 3 true)
    	('Jon Snow' 4 false)
      	('Eddard Stark' 1 true)).
	
	df := DataFrame fromRows: rows.
	
	self assert: df rowNames equals: #(1 2 3).
	self assert: df columnNames equals: #(1 2 3).
	
	"We know that it works, because we have tests for it in DataFrameInternalTests"
	expectedValues := DataFrameInternal fromRows: rows.
	
	self assert: df contents equals: expectedValues.
]

{ #category : #tests }
DataFrameTests >> testInequality [

	| df1 df2 df3 df4 df5 |
	
	"Other data frames will be compared to this one"
	df1 := DataFrame fromRows: #((1 2)(3 4)).
	df1 rowNames: #(a b).
	df1 columnNames: #(x y).
	
	"This one has different row names"
	df2 := DataFrame fromRows: #((1 2)(3 4)).
	df2 rowNames: #(c b).
	df2 columnNames: #(x y).
	
	"This one has different column names"
	df3 := DataFrame fromRows: #((1 2)(3 4)).
	df3 rowNames: #(a b).
	df3 columnNames: #(x z).
	
	"This one has different dimensions"
	df4 := DataFrame fromRows: #((1 2)(3 4)(5 6)).
	df4 rowNames: #(a b).
	df4 columnNames: #(x z).
	
	"This one has different values"
	df5 := DataFrame fromRows: #((1 2)(3 5)).
	df5 rowNames: #(a b).
	df5 columnNames: #(x z).

	self assert: (df2 = df1) not.
	self assert: (df3 = df1) not.
	self assert: (df4 = df1) not.
	self assert: (df5 = df1) not.
]

{ #category : #tests }
DataFrameTests >> testOrderBy [

	| actual expected |

	expected := DataFrame fromRows: #(
		('Barcelona' 1.609 true)
   		('Dubai' 2.789 true)
		('London' 8.788 false)).
		
	expected rowNames: #(A B C).
	expected columnNames: #(City Population BeenThere).
	
	actual := df orderBy: #Population.
	self assert: actual equals: expected.
]

{ #category : #tests }
DataFrameTests >> testOrderByUsing [
	"Order by second letter of city name"
	| actual expected |

	expected := DataFrame fromRows: #(
		('Barcelona' 1.609 true)
		('London' 8.788 false)
		('Dubai' 2.789 true)).
		
	expected rowNames: #(A C B).
	expected columnNames: #(City Population BeenThere).
	
	actual := df orderBy: #City using: [ :name1 :name2 |
		name1 second <= name2 second ].
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataFrameTests >> testOrderDescendingBy [

	| actual expected |

	expected := DataFrame fromRows: #(
		('London' 8.788 false)
		('Dubai' 2.789 true)
		('Barcelona' 1.609 true)).
		
	expected rowNames: #(C B A).
	expected columnNames: #(City Population BeenThere).
	
	actual := df orderDescendingBy: #Population.
	self assert: actual equals: expected.
]

{ #category : #tests }
DataFrameTests >> testPrintOn [

	| expected actual |
	
	expected := 'a DataFrame (3@3)'.
	
	actual := String new writeStream.
	df printOn: actual.
	actual := actual contents.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataFrameTests >> testQuantitativeColumns [

	self
		assert: df quantitativeColumns
		equals: #(Population).
]

{ #category : #tests }
DataFrameTests >> testRemoveColumn [

	| expected |
	
	expected := DataFrame fromRows: #(
		('Barcelona' true)
   		('Dubai' true)
   		('London' false)).
		
	expected rowNames: #(A B C).
	expected columnNames: #(City BeenThere).
		
	df removeColumn: #Population.
	
	self assert: df equals: expected.
]

{ #category : #tests }
DataFrameTests >> testRemoveColumnAt [

	| expected |
	
	expected := DataFrame fromRows: #(
		('Barcelona' true)
   		('Dubai' true)
   		('London' false)).
		
	expected rowNames: #(A B C).
	expected columnNames: #(City BeenThere).
		
	df removeColumnAt: 2.
	
	self assert: df equals: expected.
]

{ #category : #tests }
DataFrameTests >> testRemoveFirstRow [

	| expected |
	
	expected := DataFrame fromRows: #(
   		('Dubai' 2.789 true)
   		('London' 8.788 false)).
		
	expected rowNames: #(B C).
	expected columnNames: #(City Population BeenThere).
		
	df removeFirstRow.
	
	self assert: df equals: expected.
]

{ #category : #tests }
DataFrameTests >> testRemoveLastRow [

	| expected |
	
	expected := DataFrame fromRows: #(
		('Barcelona' 1.609 true)
   		('Dubai' 2.789 true)).
		
	expected rowNames: #(A B).
	expected columnNames: #(City Population BeenThere).
		
	df removeLastRow.
	
	self assert: df equals: expected.
]

{ #category : #tests }
DataFrameTests >> testRemoveRow [

	| expected |
	
	expected := DataFrame fromRows: #(
		('Barcelona' 1.609 true)
   		('London' 8.788 false)).
		
	expected rowNames: #(A C).
	expected columnNames: #(City Population BeenThere).
		
	df removeRow: #B.
	
	self assert: df equals: expected.
]

{ #category : #tests }
DataFrameTests >> testRemoveRowAt [

	| expected |
	
	expected := DataFrame fromRows: #(
		('Barcelona' 1.609 true)
   		('London' 8.788 false)).
		
	expected rowNames: #(A C).
	expected columnNames: #(City Population BeenThere).
		
	df removeRowAt: 2.
	
	self assert: df equals: expected.
]

{ #category : #tests }
DataFrameTests >> testRow [

	| actualSeries expectedSeries |

	expectedSeries := DataSeries fromArray:
		#('Dubai' 2.789 true).
		
	expectedSeries name: #B.
	expectedSeries keys: df columnNames.
	
	actualSeries := df row: #B.
	
	self assert: actualSeries equals: expectedSeries.
]

{ #category : #tests }
DataFrameTests >> testRowAt [

	| actualSeries expectedSeries |

	expectedSeries := DataSeries fromArray:
		#('Dubai' 2.789 true).
		
	expectedSeries name: #B.
	expectedSeries keys: df columnNames.
	
	actualSeries := df rowAt: 2.
	
	self assert: actualSeries equals: expectedSeries.
]

{ #category : #tests }
DataFrameTests >> testRowAtPut [

	| actual expected |

	expected := DataFrame fromRows: #(
		('Barcelona' 1.609 true)
   		('X' 'Y' 'Z')
   		('London' 8.788 false)).
		
	expected rowNames: #(A B C).
	expected columnNames: #(City Population BeenThere).
	
	actual := df.
	actual rowAt: 2 put: #('X' 'Y' 'Z').
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataFrameTests >> testRowPut [

	| actual expected |

	expected := DataFrame fromRows: #(
		('Barcelona' 1.609 true)
   		('X' 'Y' 'Z')
   		('London' 8.788 false)).
		
	expected rowNames: #(A B C).
	expected columnNames: #(City Population BeenThere).
	
	actual := df.
	actual row: #B put: #('X' 'Y' 'Z').
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataFrameTests >> testRows [

	| rowNames actualDataFrame expectedDataFrame |
	
	rowNames := #(A C).
	
	expectedDataFrame := DataFrame fromRows: #(
		('Barcelona' 1.609 true)
   		('London' 8.788 false)).
		
	expectedDataFrame rowNames: rowNames.
	expectedDataFrame columnNames: df columnNames.
	
	actualDataFrame := df rows: rowNames.
	
	self assert: actualDataFrame equals: expectedDataFrame.
]

{ #category : #tests }
DataFrameTests >> testRowsAt [

	| rowNumbers actualDataFrame expectedDataFrame |
	
	rowNumbers := #(1 3).
	
	expectedDataFrame := DataFrame fromRows: #(
		('Barcelona' 1.609 true)
   		('London' 8.788 false)).
		
	expectedDataFrame rowNames:
		(rowNumbers collect: [ :i |
			df rowNames at: i ]).
	expectedDataFrame columnNames: df columnNames.
	
	actualDataFrame := df rowsAt: rowNumbers.
	
	self assert: actualDataFrame equals: expectedDataFrame.
]

{ #category : #tests }
DataFrameTests >> testRowsFromTo [

	| actualDataFrame expectedDataFrame |
		
	expectedDataFrame := DataFrame fromRows: #(
   		('Dubai' 2.789 true)
   		('London' 8.788 false)).
		
	expectedDataFrame rowNames: #(B C).
	expectedDataFrame columnNames: df columnNames.
	
	actualDataFrame := df rowsFrom: 2 to: 3.
	
	self assert: actualDataFrame equals: expectedDataFrame.
]

{ #category : #tests }
DataFrameTests >> testToColumnApplyElementwise [

	| expected |
	
	expected := DataFrame fromRows: #(
		('Barcelona' '1.609' true)
   		('Dubai' '2.789' true)
   		('London' '8.788' false)).
		
	expected rowNames: #(A B C).
	expected columnNames: #(City Population BeenThere).
		
	df toColumn: #Population
		applyElementwise: [ :each | each asString ].
	
	self assert: df equals: expected.
]

{ #category : #tests }
DataFrameTests >> testToColumnAtApplyElementwise [

	| expected |
	
	expected := DataFrame fromRows: #(
		('Barcelona' '1.609' true)
   		('Dubai' '2.789' true)
   		('London' '8.788' false)).
		
	expected rowNames: #(A B C).
	expected columnNames: #(City Population BeenThere).
		
	df toColumnAt: 2
		applyElementwise: [ :each | each asString ].
	
	self assert: df equals: expected.
]

{ #category : #tests }
DataFrameTests >> testToColumnsApplyElementwise [

	| expected |
	
	expected := DataFrame fromRows: #(
		('Barcelona' '1.609' 'true')
   		('Dubai' '2.789' 'true')
   		('London' '8.788' 'false')).
		
	expected rowNames: #(A B C).
	expected columnNames: #(City Population BeenThere).
		
	df toColumns: #(Population BeenThere)
		applyElementwise: [ :each | each asString ].
	
	self assert: df equals: expected.
]

{ #category : #tests }
DataFrameTests >> testToColumnsAtApplyElementwise [

	| expected |
	
	expected := DataFrame fromRows: #(
		('Barcelona' '1.609' 'true')
   		('Dubai' '2.789' 'true')
   		('London' '8.788' 'false')).
		
	expected rowNames: #(A B C).
	expected columnNames: #(City Population BeenThere).
		
	df toColumnsAt: #(2 3)
		applyElementwise: [ :each | each asString ].
	
	self assert: df equals: expected.
]

{ #category : #tests }
DataFrameTests >> testTransposed [

	| expected |
	
	expected := DataFrame fromRows: #(
		('Barcelona' 'Dubai' 'London')
		(1.609 2.789 8.788)
   		(true true false)).
		
	expected rowNames: df columnNames.
	expected columnNames: df rowNames.
	
	self assert: df transposed equals: expected.
	

]

{ #category : #tests }
DataFrameTests >> testVarSizeInstanceCreation [

	| df |
	df := DataFrame new: 3@2.
	
	self assert: df numberOfRows equals: 3.
	self assert: df numberOfColumns equals: 2.
	
	self assert: df rowNames equals: #(1 2 3).
	self assert: df columnNames equals: #(1 2).
]

{ #category : #tests }
DataFrameTests >> testWithKeyDo [

	| actual expected |

	expected := Dictionary new.
	expected at: #A put: #('Barcelona' 1.609 true) asDataSeries.
	expected at: #B put: #('Dubai' 2.789 true) asDataSeries.
	expected at: #C put: #('London' 8.788 false) asDataSeries.
		
	expected keysAndValuesDo: [ :name :each |
		each keys: #(City Population BeenThere).
		each name: name ].
		
	actual := Dictionary new.
	
	df withKeyDo: [ :each :key |
		actual at: key put: each ].
	
	self assert: actual equals: expected.
]
