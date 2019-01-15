Class {
	#name : #DataFrameInternalTests,
	#superclass : #TestCase,
	#instVars : [
		'df'
	],
	#category : 'DataFrame-Tests'
}

{ #category : #initialization }
DataFrameInternalTests >> setUp [

	df := DataFrameInternal fromRows: #(
		('Barcelona' 1.609 true)
   		('Dubai' 2.789 true)
   		('London' 8.788 false)).
]

{ #category : #tests }
DataFrameInternalTests >> testAddColumn [

	| expected |
	
	expected := DataFrameInternal fromRows: #(
		('Barcelona' 1.609 true 4)
   		('Dubai' 2.789 true 3)
   		('London' 8.788 false 4)).
		
	df addColumn: #(4 3 4).
	
	self assert: df equals: expected.
	

]

{ #category : #tests }
DataFrameInternalTests >> testAddColumnSizeMismatch [
	
	| aBlock |
	aBlock := [ df addColumn: #(1 2 3 4) ].
	
	self should: aBlock raise: SizeMismatch.
	

]

{ #category : #tests }
DataFrameInternalTests >> testAddRow [

	| expected |
	
	expected := DataFrameInternal fromRows: #(
		('Barcelona' 1.609 true)
   		('Dubai' 2.789 true)
   		('London' 8.788 false)
		('Lviv' 0.724 true)).
		
	df addRow: #('Lviv' 0.724 true).
	
	self assert: df equals: expected.
	

]

{ #category : #tests }
DataFrameInternalTests >> testAddRowSizeMismatch [
	
	| aBlock |
	aBlock := [ df addRow: #(1 2) ].
	
	self should: aBlock raise: SizeMismatch.
	

]

{ #category : #tests }
DataFrameInternalTests >> testAsArrayOfColumns [

	| expected |
	
	expected := #(
		('Barcelona' 'Dubai' 'London')
		(1.609 2.789 8.788)
   		(true true false)).
	
	self assert: df asArrayOfColumns equals: expected.
	

]

{ #category : #tests }
DataFrameInternalTests >> testAsArrayOfRows [

	| expected |
	
	expected := #(
		('Barcelona' 1.609 true)
   		('Dubai' 2.789 true)
   		('London' 8.788 false)).
	
	self assert: df asArrayOfRows equals: expected.
	

]

{ #category : #tests }
DataFrameInternalTests >> testAtAt [
	
	self assert: (df at: 2 at: 2) closeTo: 2.789.
]

{ #category : #tests }
DataFrameInternalTests >> testAtAtPut [

	| matrix expected actual |
	
	matrix := Matrix rows: 3 columns: 2
		contents: #(1 2 3 4 5 6).
		
	actual := DataFrameInternal fromMatrix: matrix.
	actual at: 2 at: 2 put: 10.
	
	matrix at: 2 at: 2 put: 10.
	expected := DataFrameInternal fromMatrix: matrix.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataFrameInternalTests >> testCollect [

	| dfInternal dfActual dfExpected |
	
	dfInternal := DataFrameInternal fromRows:
		#((1 2)(3 4)(5 6)).
		
	dfExpected := DataFrameInternal fromRows:
		#((10 20)(30 40)(50 60)).
		
	dfActual := dfInternal
		collect: [ :each |
			each * 10 ].
		
	self assert: dfActual equals: dfExpected
]

{ #category : #tests }
DataFrameInternalTests >> testColumnAt [

	| actualColumn expectedColumn |
	
	actualColumn := df columnAt: 2.
	expectedColumn := #(1.609 2.789 8.788).
	
	self assert: actualColumn equals: expectedColumn.
]

{ #category : #tests }
DataFrameInternalTests >> testColumnAtPut [

	| actual expected |

	expected := DataFrameInternal fromRows: #(
		('X' 1.609 0)
   		('Y' 2.789 1)
   		('Z' 8.788 0)).
	
	actual := df.
	actual columnAt: 1 put: #(X Y Z).
	actual columnAt: 3 put: #(0 1 0).
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataFrameInternalTests >> testColumnsAt [

	| columnNumbers dfActual dfExpected |
	
	columnNumbers := #(1 3).
	
	dfExpected := DataFrameInternal fromRows: #(
		('Barcelona' true)
   		('Dubai' true)
   		('London' false)).
		
	dfActual := df columnsAt: columnNumbers.
	
	self assert: dfActual equals: dfExpected.
]

{ #category : #tests }
DataFrameInternalTests >> testDeepCopy [

	| dfCopy |
	
	dfCopy := df deepCopy.
	
	self assert: (df = dfCopy).
	self assert: (df == dfCopy) not.
]

{ #category : #tests }
DataFrameInternalTests >> testDo [

	| dfInternal sum |
	
	dfInternal := DataFrameInternal fromRows:
		#((1 2)(3 4)(5 6)).
		
	sum := 0.
	
	dfInternal do: [ :each |
		sum := sum + each ].
	
	self assert: sum equals: 21.
]

{ #category : #tests }
DataFrameInternalTests >> testFromColumns [

	| dfActual dfExpected |
	
	dfExpected := DataFrameInternal fromMatrix: 		(Matrix rows: 3 columns: 2 contents: #(1 2 3 4 5 6)).
		
	dfActual := DataFrameInternal fromColumns: #((1 3 5)(2 4 6)).
	
	self assert: dfActual equals: dfExpected.
]

{ #category : #tests }
DataFrameInternalTests >> testFromMatrix [

	| dfi matrix |
	
	matrix := Matrix rows: 3 columns: 2
		contents: #(1 2 3 4 5 6).
		
	dfi := DataFrameInternal fromMatrix: matrix.
	
	self assert: dfi asMatrix equals: matrix.
]

{ #category : #tests }
DataFrameInternalTests >> testFromRows [
	
	| dfActual dfExpected |
	
	dfExpected := DataFrameInternal fromMatrix: 		(Matrix rows: 3 columns: 2 contents: #(1 2 3 4 5 6)).
		
	dfActual := DataFrameInternal fromRows: #((1 2)(3 4)(5 6)).
	
	self assert: dfActual equals: dfExpected.
	
	
]

{ #category : #tests }
DataFrameInternalTests >> testPrintOn [

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
DataFrameInternalTests >> testRemoveColumnAt [

	| expected |
	
	expected := DataFrameInternal fromRows: #(
		('Barcelona' true)
   		('Dubai' true)
   		('London' false)).
		
	df removeColumnAt: 2.
	
	self assert: df equals: expected.
	

]

{ #category : #tests }
DataFrameInternalTests >> testRemoveRowAt [

	| expected |
	
	expected := DataFrameInternal fromRows: #(
		('Barcelona' 1.609 true)
   		('London' 8.788 false)).
		
	df removeRowAt: 2.
	
	self assert: df equals: expected.
	

]

{ #category : #tests }
DataFrameInternalTests >> testRowAt [

	| actualRow expectedRow |
	
	actualRow := df rowAt: 2.
	expectedRow := #('Dubai' 2.789 true).
	
	self assert: actualRow equals: expectedRow.
]

{ #category : #tests }
DataFrameInternalTests >> testRowAtPut [

	| actual expected |

	expected := DataFrameInternal fromRows: #(
		('Barcelona' 1.609 true)
   		('X' 'Y' 'Z')
   		('London' 8.788 false)).
	
	actual := df.
	actual rowAt: 2 put: #(X Y Z).
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataFrameInternalTests >> testRowsAt [

	| rowNumbers dfActual dfExpected |
	
	rowNumbers := #(1 3).
	
	dfExpected := DataFrameInternal fromRows: #(
		('Barcelona' 1.609 true)
   		('London' 8.788 false)).
		
	dfActual := df rowsAt: rowNumbers.
	
	self assert: dfActual equals: dfExpected.
]

{ #category : #tests }
DataFrameInternalTests >> testVarSizeInstanceCreation [

	| dfActual |
	dfActual := DataFrameInternal new: 6@8.
	
	self assert: dfActual numberOfRows equals: 6.
	self assert: dfActual numberOfColumns equals: 8.
]

{ #category : #tests }
DataFrameInternalTests >> testWithIndicesCollect [

	| dfInternal actual expected |
	
	dfInternal := DataFrameInternal fromRows:
		#((1 2)(3 4)(5 6)).
		
	expected := DataFrameInternal fromRows:
		#((true true)(true true)(true true)).
		
	actual := dfInternal
		withIndicesCollect: [ :each :i :j |
			each = ((i - 1) * 2 + j) ].
		
	self assert: actual equals: expected
]

{ #category : #tests }
DataFrameInternalTests >> testWithIndicesDo [

	| dfInternal |
	
	dfInternal := DataFrameInternal fromRows:
		#((1 2)(3 4)(5 6)).
		
	dfInternal withIndicesDo: [ :each :i :j |
		self assert: each equals: ((i - 1) * 2 + j) ].
]
