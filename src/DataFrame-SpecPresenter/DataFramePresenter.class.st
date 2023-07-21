"
I am a Spec presenter for DataFrame.

I am used in the inspector to display the data as a table. I can also be used in other Spec tools that need to display and manipulate data frames.
"
Class {
	#name : #DataFramePresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'data',
		'tablePresenter'
	],
	#category : #'DataFrame-SpecPresenter'
}

{ #category : #examples }
DataFramePresenter class >> example [

	<example>
	| data |
	
	data := DataFrame withRows: #(
		('Barcelona' 1.609 true)
		('Dubai' 2.789 true)
		('London' 8.788 false)).

	data rowNames: #('A' 'B' 'C').
	data columnNames: #('City' 'Population' 'BeenThere').
	
	(self on: data) open.
]

{ #category : #layout }
DataFramePresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		add: tablePresenter;
		yourself.
]

{ #category : #initialization }
DataFramePresenter >> initializePresenters [

	tablePresenter := self newTable.
	data ifNotNil: [ self showDataInTable ].
]

{ #category : #initialization }
DataFramePresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: data asString;
		initialExtent: 600@500.
]

{ #category : #'accessing - model' }
DataFramePresenter >> setModelBeforeInitialization: aDataFrame [

	data := aDataFrame
]

{ #category : #showing }
DataFramePresenter >> showDataInTable [

	tablePresenter addColumn: (SpIndexTableColumn new
		title: '#';
		sortFunction: #yourself ascending;
		beNotExpandable;
		yourself).

	(data columnNames) doWithIndex: [ :headerName :columnIndex |
		tablePresenter addColumn: (SpStringTableColumn
			title: headerName
			evaluated: [ :rowWithName | rowWithName at: columnIndex + 1 ]) ].

	tablePresenter items: data asArrayOfRowsWithName.
]

{ #category : #accessing }
DataFramePresenter >> tablePresenter [
	"Accessor for testing"

	^ tablePresenter
]
