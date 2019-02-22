Class {
	#name : #DataSeriesInternalTests,
	#superclass : #TestCase,
	#instVars : [
		'series'
	],
	#category : #'DataFrame-Tests'
}

{ #category : #initialization }
DataSeriesInternalTests >> setUp [

	series := DataSeriesInternal
		fromArray: (10 to: 100 by: 10) asArray.
]

{ #category : #initialization }
DataSeriesInternalTests >> testAdd [

	| expected |
	
	expected := DataSeriesInternal fromArray:
		#(10 20 30 40 50 60 70 80 90 100 -1).
		
	series add: -1.
		
	self assert: series equals: expected.
]

{ #category : #initialization }
DataSeriesInternalTests >> testAt [

	self assert: (series at: 2) equals: 20.
]

{ #category : #initialization }
DataSeriesInternalTests >> testAtIfAbsent [

	self assert: (series at: 2) equals: 20.
	
	self assert: (series at: 100 ifAbsent: [ 'Executing a block' ])
		equals: 'Executing a block'.
]

{ #category : #initialization }
DataSeriesInternalTests >> testAtPut [

	| expected |
	
	series at: 6 put: -2.	
	expected := DataSeriesInternal fromArray:
		#(10 20 30 40 50 -2 70 80 90 100).
	
	self assert: series equals: expected.
]

{ #category : #initialization }
DataSeriesInternalTests >> testCollect [

	| expected actual |
	
	expected := DataSeriesInternal fromArray: (1 to: 10) asArray.
	actual := series collect: [ :each | each / 10 ].

	self assert: actual equals: expected.
]

{ #category : #initialization }
DataSeriesInternalTests >> testCollectWithIndex [

	| expected actual |
	
	expected := DataSeriesInternal fromArray: ((1 to: 10) collect: [ :k | k * 2 ]).
	actual := series collectWithIndex: [ :each :i |
		each / 10 + i ].

	self assert: actual equals: expected.
]

{ #category : #initialization }
DataSeriesInternalTests >> testDo [

	| sum |
	sum := 0.
	
	series do: [ :each |
		sum := sum + each ].
	
	self assert: sum equals: 550.
]

{ #category : #initialization }
DataSeriesInternalTests >> testDoWithIndex [

	| sum |
	sum := 0.
	
	series doWithIndex: [ :each :i |
		sum := sum + (each / i) ].
	
	self assert: sum equals: 100.
]

{ #category : #initialization }
DataSeriesInternalTests >> testPrintOn [

	| population expected actual |
	population := DataSeriesInternal fromArray: #(1.609 2.789 8.788).
	
	expected := '#(1.609 2.789 8.788)'.
	
	actual := String new writeStream.
	population printOn: actual.
	actual := actual contents.
	
	self assert: actual equals: expected.
]

{ #category : #initialization }
DataSeriesInternalTests >> testRemoveAt [

	| expected |
	
	expected := DataSeriesInternal fromArray:
		#(10 30 40 50 60 70 80 90 100).
		
	series removeAt: 2.
		
	self assert: series equals: expected.
]

{ #category : #initialization }
DataSeriesInternalTests >> testVarSizeInstanceCreation [

	| seriesInternal |
	
	seriesInternal := DataSeriesInternal new: 10.
	self assert: seriesInternal size equals: 10.
]
