Class {
	#name : #DataSeriesInternalTest,
	#superclass : #TestCase,
	#instVars : [
		'series'
	],
	#category : #'DataFrame-Tests'
}

{ #category : #initialization }
DataSeriesInternalTest >> setUp [

	series := DataSeriesInternal
		withValues: (10 to: 100 by: 10) asArray.
]

{ #category : #initialization }
DataSeriesInternalTest >> testAdd [

	| expected |
	
	expected := DataSeriesInternal withValues:
		#(10 20 30 40 50 60 70 80 90 100 -1).
		
	series add: -1.
		
	self assert: series equals: expected.
]

{ #category : #initialization }
DataSeriesInternalTest >> testAt [

	self assert: (series at: 2) equals: 20.
]

{ #category : #initialization }
DataSeriesInternalTest >> testAtIfAbsent [

	self assert: (series at: 2) equals: 20.
	
	self assert: (series at: 100 ifAbsent: [ 'Executing a block' ])
		equals: 'Executing a block'.
]

{ #category : #initialization }
DataSeriesInternalTest >> testAtPut [

	| expected |
	
	series at: 6 put: -2.	
	expected := DataSeriesInternal withValues:
		#(10 20 30 40 50 -2 70 80 90 100).
	
	self assert: series equals: expected.
]

{ #category : #initialization }
DataSeriesInternalTest >> testCollect [

	| expected actual |
	
	expected := DataSeriesInternal withValues: (1 to: 10) asArray.
	actual := series collect: [ :each | each / 10 ].

	self assert: actual equals: expected.
]

{ #category : #initialization }
DataSeriesInternalTest >> testCollectWithIndex [

	| expected actual |
	
	expected := DataSeriesInternal withValues: ((1 to: 10) collect: [ :k | k * 2 ]).
	actual := series collectWithIndex: [ :each :i |
		each / 10 + i ].

	self assert: actual equals: expected.
]

{ #category : #initialization }
DataSeriesInternalTest >> testDo [

	| sum |
	sum := 0.
	
	series do: [ :each |
		sum := sum + each ].
	
	self assert: sum equals: 550.
]

{ #category : #initialization }
DataSeriesInternalTest >> testDoWithIndex [

	| sum |
	sum := 0.
	
	series doWithIndex: [ :each :i |
		sum := sum + (each / i) ].
	
	self assert: sum equals: 100.
]

{ #category : #initialization }
DataSeriesInternalTest >> testPrintOn [

	| population expected actual |
	population := DataSeriesInternal withValues: #(1.609 2.789 8.788).
	
	expected := '#(1.609 2.789 8.788)'.
	
	actual := String new writeStream.
	population printOn: actual.
	actual := actual contents.
	
	self assert: actual equals: expected.
]

{ #category : #initialization }
DataSeriesInternalTest >> testRemoveAt [

	| expected |
	
	expected := DataSeriesInternal withValues:
		#(10 30 40 50 60 70 80 90 100).
		
	series removeAt: 2.
		
	self assert: series equals: expected.
]

{ #category : #initialization }
DataSeriesInternalTest >> testVarSizeInstanceCreation [

	| seriesInternal |
	
	seriesInternal := DataSeriesInternal new: 10.
	self assert: seriesInternal size equals: 10.
]
