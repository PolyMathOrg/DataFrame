Class {
	#name : #DataFrameInternalTest,
	#superclass : #TestCase,
	#instVars : [
		'df'
	],
	#category : #'DataFrame-Tests'
}

{ #category : #initialization }
DataFrameInternalTest >> setUp [

	df := DataFrameInternal withRows: #(
		('Barcelona' 1.609 true)
   		('Dubai' 2.789 true)
   		('London' 8.788 false)).
]

{ #category : #tests }
DataFrameInternalTest >> testAddColumnAtPosition [

	| expected |
	
	expected := DataFrameInternal withRows: #(
		('Barcelona' 1.609 4 true)
   		('Dubai' 2.789 3 true)
   		('London' 8.788 4 false)).
		
	df addColumn: #(4 3 4) atPosition: 3.
	
	self assert: df equals: expected.
	

]

{ #category : #tests }
DataFrameInternalTest >> testAddColumnAtPositionSizeMismatch [
	
	| aBlock |
	aBlock := [ df addColumn: #(1 2 3 4) atPosition: 3 ].
	
	self should: aBlock raise: SizeMismatch.
	

]

{ #category : #tests }
DataFrameInternalTest >> testAddRowAtPosition [

	| expected |
	
	expected := DataFrameInternal withRows: #(
		('Barcelona' 1.609 true)
   		('Dubai' 2.789 true)
		('Lviv' 0.724 true)
   		('London' 8.788 false)).
		
	df addRow: #('Lviv' 0.724 true) atPosition: 3.
	
	self assert: df equals: expected.
	

]

{ #category : #tests }
DataFrameInternalTest >> testAddRowAtPositionSizeMismatch [
	
	| aBlock |
	aBlock := [ df addRow: #(1 2) atPosition: 3 ].
	
	self should: aBlock raise: SizeMismatch.
	

]

{ #category : #tests }
DataFrameInternalTest >> testAsArrayOfColumns [

	| expected |
	
	expected := #(
		('Barcelona' 'Dubai' 'London')
		(1.609 2.789 8.788)
   		(true true false)).
	
	self assert: df asArrayOfColumns equals: expected.
	

]

{ #category : #tests }
DataFrameInternalTest >> testAsArrayOfRows [

	| expected |
	
	expected := #(
		('Barcelona' 1.609 true)
   		('Dubai' 2.789 true)
   		('London' 8.788 false)).
	
	self assert: df asArrayOfRows equals: expected.
	

]

{ #category : #tests }
DataFrameInternalTest >> testAtAt [
	
	self assert: (df at: 2 at: 2) closeTo: 2.789.
]

{ #category : #tests }
DataFrameInternalTest >> testAtAtPut [

	| array2D expected actual |
	
	array2D := Array2D rows: 3 columns: 2
		contents: #(1 2 3 4 5 6).
		
	actual := DataFrameInternal fromArray2D: array2D.
	actual at: 2 at: 2 put: 10.
	
	array2D := Array2D rows: 3 columns: 2
		contents: #(1 2 3 10 5 6).
		
	expected := DataFrameInternal fromArray2D: array2D.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataFrameInternalTest >> testCollect [

	| dfInternal dfActual dfExpected |
	
	dfInternal := DataFrameInternal withRows:
		#((1 2)(3 4)(5 6)).
		
	dfExpected := DataFrameInternal withRows:
		#((10 20)(30 40)(50 60)).
		
	dfActual := dfInternal
		collect: [ :each |
			each * 10 ].
		
	self assert: dfActual equals: dfExpected
]

{ #category : #tests }
DataFrameInternalTest >> testColumnAt [

	| actualColumn expectedColumn |
	
	actualColumn := df columnAt: 2.
	expectedColumn := #(1.609 2.789 8.788).
	
	self assert: actualColumn equals: expectedColumn.
]

{ #category : #tests }
DataFrameInternalTest >> testColumnAtPut [

	| actual expected |

	expected := DataFrameInternal withRows: #(
		('X' 1.609 0)
   		('Y' 2.789 1)
   		('Z' 8.788 0)).
	
	actual := df.
	actual columnAt: 1 put: #(X Y Z).
	actual columnAt: 3 put: #(0 1 0).
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataFrameInternalTest >> testColumnsAt [

	| columnNumbers dfActual dfExpected |
	
	columnNumbers := #(1 3).
	
	dfExpected := DataFrameInternal withRows: #(
		('Barcelona' true)
   		('Dubai' true)
   		('London' false)).
		
	dfActual := df columnsAt: columnNumbers.
	
	self assert: dfActual equals: dfExpected.
]

{ #category : #tests }
DataFrameInternalTest >> testCreateDataFrameInternalWithColumns [

	| array2D expected actual |
	
	array2D := Array2D
			rows: 3
			columns: 2
			contents: #(1 2 3 4 5 6).
	
	expected := DataFrameInternal fromArray2D: array2D.
	actual := DataFrameInternal withColumns: #((1 3 5)(2 4 6)).
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataFrameInternalTest >> testCreateDataFrameInternalWithRows [
	
	| array2D actual expected |
	
	array2D := Array2D
		rows: 3
		columns: 2
		contents: #(1 2 3 4 5 6).
	
	expected := DataFrameInternal fromArray2D: array2D.	
	actual := DataFrameInternal withRows: #((1 2)(3 4)(5 6)).
	
	self assert: actual equals: expected.
	
	
]

{ #category : #tests }
DataFrameInternalTest >> testDeepCopy [

	| dfCopy |
	
	dfCopy := df deepCopy.
	
	self assert: df equals: dfCopy.
	self deny: df == dfCopy.
]

{ #category : #tests }
DataFrameInternalTest >> testDo [

	| dfInternal sum |
	
	dfInternal := DataFrameInternal withRows:
		#((1 2)(3 4)(5 6)).
		
	sum := 0.
	
	dfInternal do: [ :each |
		sum := sum + each ].
	
	self assert: sum equals: 21.
]

{ #category : #tests }
DataFrameInternalTest >> testFromArray2D [

	| dfi array2D |
	
	array2D := Array2D
		rows: 3
		columns: 2
		contents: #(1 2 3 4 5 6).
		
	dfi := DataFrameInternal fromArray2D: array2D.
	
	self assert: dfi asArray2D equals: array2D.
]

{ #category : #tests }
DataFrameInternalTest >> testPrintOn [

	| expected actual |
	
	expected := String new writeStream.
	expected
		nextPutAll: '(''Barcelona'' 1.609 true'; cr;
		nextPutAll: '''Dubai'' 2.789 true'; cr;
		nextPutAll: '''London'' 8.788 false )'.
	expected := expected contents.
	
	actual := String new writeStream.
	df printOn: actual.
	actual := actual contents.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataFrameInternalTest >> testRemoveColumnAt [

	| expected |
	
	expected := DataFrameInternal withRows: #(
		('Barcelona' true)
   		('Dubai' true)
   		('London' false)).
		
	df removeColumnAt: 2.
	
	self assert: df equals: expected.
	

]

{ #category : #tests }
DataFrameInternalTest >> testRemoveColumnsOfRowElementsSatisfingOnRow [

	| expected |
	
	df := DataFrameInternal withRows: #(
		('Barcelona' 1.609 nil)
   		('Dubai' 2.789 true)
   		('London' nil nil)
		('Washington' nil true)
		('Delhi' 10.422 nil)).
	
	expected := DataFrameInternal withRows: #(
		('Barcelona')
   		('Dubai')
   		('London')
		('Washington')
		('Delhi')).
	
	self assert: (df removeColumnsOfRowElementsSatisfing: [ :ele | ele isNil ] onRow: 3) equals: expected.
]

{ #category : #tests }
DataFrameInternalTest >> testRemoveRowAt [

	| expected |
	
	expected := DataFrameInternal withRows: #(
		('Barcelona' 1.609 true)
   		('London' 8.788 false)).
		
	df removeRowAt: 2.
	
	self assert: df equals: expected.
	

]

{ #category : #tests }
DataFrameInternalTest >> testRemoveRowsOfColumnElementsSatisfingOnColumn [

	| expected |
	
	df := DataFrameInternal withRows: #(
		('Barcelona' 1.609 nil)
   		('Dubai' 2.789 true)
   		('London' 8.788 nil)
		('Washington' nil true)
		('Delhi' 10.422 nil)).
	
	expected := DataFrameInternal withRows: #(
   		('Dubai' 2.789 true)
		('Washington' nil true)).
	
	self assert: (df removeRowsOfColumnElementsSatisfing: [ :ele | ele isNil ] onColumn: 3) equals: expected.


]

{ #category : #tests }
DataFrameInternalTest >> testReplaceMissingValuesStrings [

	| expected |
	
	df := DataFrameInternal withRows: #(
		('Barcelona' 1.609 'null')
   		('Dubai' '?' true)
   		(nil 8.788 '')).
		
	expected := DataFrameInternal withRows: #(
		('Barcelona' 1.609 nil)
   		('Dubai' nil true)
   		(nil 8.788 nil)).
	
	self assert: (df replaceMissingValuesStrings: #('null' '?' '') asSet) equals: expected.


]

{ #category : #tests }
DataFrameInternalTest >> testReplaceMissingValuesStringsOnEmptySet [

	| expected |

	df := DataFrameInternal withRows: #(
		('Barcelona' 1.609 true)
   		('Dubai' 2.789 true)
   		('London' 8.788 false)).
	
	expected := DataFrameInternal withRows: #(
		('Barcelona' 1.609 true)
   		('Dubai' 2.789 true)
   		('London' 8.788 false)).
	
	self assert: (df replaceMissingValuesStrings: #() asSet) equals: expected.
]

{ #category : #tests }
DataFrameInternalTest >> testRowAt [

	| actualRow expectedRow |
	
	actualRow := df rowAt: 2.
	expectedRow := #('Dubai' 2.789 true).
	
	self assert: actualRow equals: expectedRow.
]

{ #category : #tests }
DataFrameInternalTest >> testRowAtPut [

	| actual expected |

	expected := DataFrameInternal withRows: #(
		('Barcelona' 1.609 true)
   		('X' 'Y' 'Z')
   		('London' 8.788 false)).
	
	actual := df.
	actual rowAt: 2 put: #(X Y Z).
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataFrameInternalTest >> testRowsAt [

	| rowNumbers dfActual dfExpected |
	
	rowNumbers := #(1 3).
	
	dfExpected := DataFrameInternal withRows: #(
		('Barcelona' 1.609 true)
   		('London' 8.788 false)).
		
	dfActual := df rowsAt: rowNumbers.
	
	self assert: dfActual equals: dfExpected.
]

{ #category : #tests }
DataFrameInternalTest >> testVarSizeInstanceCreation [

	| dfActual |
	dfActual := DataFrameInternal new: 6@8.
	
	self assert: dfActual numberOfRows equals: 6.
	self assert: dfActual numberOfColumns equals: 8.
]

{ #category : #tests }
DataFrameInternalTest >> testWithColumns [

	| dfi validOutput |
	dfi := DataFrameInternal withColumns: #((1 2) (1 2 3 4 5) ('a' 3.14 'bcd')).
	validOutput := Array2D
		rows: 5
		columns: 3
		contents: #(1 1 'a' 2 2 3.14 nil 3 'bcd' nil 4 nil nil 5 nil).
	
	self assert: dfi asArray2D equals: validOutput.
]

{ #category : #tests }
DataFrameInternalTest >> testWithIndicesCollect [

	| dfInternal actual expected |
	
	dfInternal := DataFrameInternal withRows:
		#((1 2)(3 4)(5 6)).
		
	expected := DataFrameInternal withRows:
		#((true true)(true true)(true true)).
		
	actual := dfInternal
		withIndicesCollect: [ :each :i :j |
			each = ((i - 1) * 2 + j) ].
		
	self assert: actual equals: expected
]

{ #category : #tests }
DataFrameInternalTest >> testWithIndicesDo [

	| dfInternal |
	
	dfInternal := DataFrameInternal withRows:
		#((1 2)(3 4)(5 6)).
		
	dfInternal withIndicesDo: [ :each :i :j |
		self assert: each equals: ((i - 1) * 2 + j) ].
]

{ #category : #tests }
DataFrameInternalTest >> testWithRows [

	| dfi validOutput |
	dfi := DataFrameInternal withRows: #((1 2) (1 2 3 4 5) ('a' 3.14 'bcd')).
	validOutput := Array2D
		rows: 3
		columns: 5
		contents: #(1 2 nil nil nil 1 2 3 4 5 'a' 3.14 'bcd' nil nil).
	
	self assert: dfi asArray2D equals: validOutput.
]
