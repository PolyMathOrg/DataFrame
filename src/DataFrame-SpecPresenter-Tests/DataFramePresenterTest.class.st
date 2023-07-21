Class {
	#name : #DataFramePresenterTest,
	#superclass : #TestCase,
	#instVars : [
		'data',
		'presenter'
	],
	#category : #'DataFrame-SpecPresenter-Tests'
}

{ #category : #running }
DataFramePresenterTest >> setUp [
	super setUp.

	data := DataFrame withRows: #(
		('Barcelona' 1.609 true)
		('Dubai' 2.789 true)
		('London' 8.788 false)).

	data rowNames: #('A' 'B' 'C').
	data columnNames: #('City' 'Population' 'BeenThere').
	
	presenter := DataFramePresenter on: data.
]

{ #category : #tests }
DataFramePresenterTest >> testTableHasCorrectNumberOfColumns [
	
	| expected actual |
	
	"One extra 'index' column containing row names"
	expected := data numberOfColumns + 1.
	actual := presenter tablePresenter columns size.

	self assert: actual equals: expected.
]

{ #category : #tests }
DataFramePresenterTest >> testTableHasCorrectNumberOfRows [
	
	| expected actual |
	
	expected := data numberOfRows.
	actual := presenter tablePresenter items size.

	self assert: actual equals: expected.
]

{ #category : #tests }
DataFramePresenterTest >> testTableHasCorrectRows [

	| expectedRow actualRow |
	
	data withIndexDo: [ :row :i |
		"We expect to get the row name followed by its values: #(name v1 v2 v3)"
		expectedRow := row asArray copyWithFirst: row name.
		actualRow := presenter tablePresenter items at: i.
		
		self assert: actualRow equals: expectedRow ]
]
