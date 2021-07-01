Class {
	#name : #DataFrameAggrGroupTest,
	#superclass : #TestCase,
	#instVars : [
		'df'
	],
	#category : #'DataFrame-Tests'
}

{ #category : #initialization }
DataFrameAggrGroupTest >> setUp [

	df := DataFrame withRows: #(
		(16.99 1.01 Female No Sun Dinner 2)
		(10.34 1.66 Male No Sun Dinner 3)
		(21.01 3.5 Male No Sun Dinner 3)
		(23.68 3.31 Male No Sun Dinner 2)
		(24.59 3.61 Female No Sun Dinner 4)).
		
	df columnNames: #(total_bill tip sex smoker day time size).
]

{ #category : #initialization }
DataFrameAggrGroupTest >> testGroupByAggregateArrayMultipleUsingAsSelector [
	| expected actual |
	
	expected := DataFrame
		withColumns: #(
			(41.58 55.03)
			(20.79 18.343333333333334)
			(2.31 2.8233333333333337))
		rowNames: #(Female Male)
		columnNames: #(total average averageTip).
		
	actual := df
		groupBy: #sex
		aggregate: {
			#total_bill using: #sum as: #total .
			#total_bill using: #average as: #average .
			#tip using: #average as: #averageTip
		}.
		
	self assert: actual equals: expected
]

{ #category : #initialization }
DataFrameAggrGroupTest >> testGroupByAggregateArrayUsingAsBlock [
	| expected actual |
	
	expected := DataFrame
		withColumns: #((20.79 18.343333333333334))
		rowNames: #(Female Male)
		columnNames: #(total).
		
	actual := df
		groupBy: #sex
		aggregate: { #total_bill using: [ :column | column sum / column size ] as: #total }.
		
	self assert: actual equals: expected
]

{ #category : #initialization }
DataFrameAggrGroupTest >> testGroupByAggregateArrayUsingAsNoSuchAggregateColumnError [
	self
		should: [
			df groupBy: #sex
				aggregate: { #NoSuchColumn using: #sum as: #total } ]
		raise: LibrarySymbolNotFoundError.
]

{ #category : #initialization }
DataFrameAggrGroupTest >> testGroupByAggregateArrayUsingAsNoSuchGroupColumnError [
	self
		should: [
			df groupBy: #NoSuchColumn
				aggregate: { #total_bill using: #sum as: #total } ]
		raise: LibrarySymbolNotFoundError.
]

{ #category : #initialization }
DataFrameAggrGroupTest >> testGroupByAggregateArrayUsingAsSameColumnError [
	self
		should: [
			df groupBy: #sex
				aggregate: { #sex using: #sum as: #total } ]
		raise: Error.
]

{ #category : #initialization }
DataFrameAggrGroupTest >> testGroupByAggregateArrayUsingAsSelector [
	| expected actual |
	
	expected := DataFrame
		withColumns: #((41.58 55.03))
		rowNames: #(Female Male)
		columnNames: #(total).
		
	actual := df
		groupBy: #sex
		aggregate: { #total_bill using: #sum as: #total }.
		
	self assert: actual equals: expected
]

{ #category : #initialization }
DataFrameAggrGroupTest >> testGroupByAggregateArrayUsingBlock [
	| expected actual |
	
	expected := DataFrame
		withColumns: #((20.79 18.343333333333334))
		rowNames: #(Female Male)
		columnNames: #(total_bill).
		
	actual := df
		groupBy: #sex
		aggregate: { #total_bill using: [ :column | column sum / column size ] }.
		
	self assert: actual equals: expected
]

{ #category : #initialization }
DataFrameAggrGroupTest >> testGroupByAggregateArrayUsingSelector [
	| expected actual |
	
	expected := DataFrame
		withColumns: #((41.58 55.03))
		rowNames: #(Female Male)
		columnNames: #(total_bill).
		
	actual := df
		groupBy: #sex
		aggregate: { #total_bill using: #sum }.
		
	self assert: actual equals: expected
]

{ #category : #initialization }
DataFrameAggrGroupTest >> testGroupByAggregateUsingAsBlock [
	| expected actual |
	
	expected := DataSeries
		withKeys: #(Female Male)
		values: #(20.79 18.343333333333334)
		name: #total.
		
	actual := df
		group: #total_bill
		by: #sex
		aggregateUsing: [ :column | column sum / column size ]
		as: #total.
		
	self assert: actual equals: expected
]

{ #category : #initialization }
DataFrameAggrGroupTest >> testGroupByAggregateUsingAsNoSuchAggregateColumnError [
	self
		should: [
			df group: #NoSuchColumn
				by: #sex
				aggregateUsing: #sum
				as: #total ]
		raise: LibrarySymbolNotFoundError.
]

{ #category : #initialization }
DataFrameAggrGroupTest >> testGroupByAggregateUsingAsNoSuchGroupColumnError [
	self
		should: [
			df group: #sex
				by: #NoSuchColumn
				aggregateUsing: #sum
				as: #total ]
		raise: LibrarySymbolNotFoundError.
]

{ #category : #initialization }
DataFrameAggrGroupTest >> testGroupByAggregateUsingAsSameColumnError [
	self
		should: [
			df group: #sex
				by: #sex
				aggregateUsing: #sum
				as: #total ]
		raise: Error.
]

{ #category : #initialization }
DataFrameAggrGroupTest >> testGroupByAggregateUsingAsSelector [
	| expected actual |
	
	expected := DataSeries
		withKeys: #(Female Male)
		values: #(41.58 55.03)
		name: #total.
		
	actual := df
		group: #total_bill
		by: #sex
		aggregateUsing: #sum
		as: #total.
		
	self assert: actual equals: expected
]

{ #category : #initialization }
DataFrameAggrGroupTest >> testGroupByAggregateUsingBlock [
	| expected actual |
	
	expected := DataSeries
		withKeys: #(Female Male)
		values: #(20.79 18.343333333333334)
		name: #total_bill.
		
	actual := df
		group: #total_bill
		by: #sex
		aggregateUsing: [ :column | column sum / column size ].
		
	self assert: actual equals: expected
]

{ #category : #initialization }
DataFrameAggrGroupTest >> testGroupByAggregateUsingNoSuchAggregateColumnError [
	self
		should: [
			df group: #NoSuchColumn
				by: #sex
				aggregateUsing: #sum ]
		raise: LibrarySymbolNotFoundError.
]

{ #category : #initialization }
DataFrameAggrGroupTest >> testGroupByAggregateUsingNoSuchGroupColumnError [
	self
		should: [
			df group: #sex
				by: #NoSuchColumn
				aggregateUsing: #sum ]
		raise: LibrarySymbolNotFoundError.
]

{ #category : #initialization }
DataFrameAggrGroupTest >> testGroupByAggregateUsingSameColumnError [
	self
		should: [
			df group: #sex
				by: #sex
				aggregateUsing: #sum ]
		raise: Error.
]

{ #category : #initialization }
DataFrameAggrGroupTest >> testGroupByAggregateUsingSelector [
	| expected actual |
	
	expected := DataSeries
		withKeys: #(Female Male)
		values: #(41.58 55.03)
		name: #total_bill.
		
	actual := df
		group: #total_bill
		by: #sex
		aggregateUsing: #sum.
		
	self assert: actual equals: expected
]
