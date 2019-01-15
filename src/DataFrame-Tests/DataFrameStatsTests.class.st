Class {
	#name : #DataFrameStatsTests,
	#superclass : #TestCase,
	#instVars : [
		'df'
	],
	#category : 'DataFrame-Core-Tests'
}

{ #category : #initialization }
DataFrameStatsTests >> setUp [

	df := DataFrame loadIris
]

{ #category : #initialization }
DataFrameStatsTests >> testAverage [

	| expected actual |
	
	expected := { 5.8433 . 3.054 . 3.7586 . 1.1986 . Float nan } asDataSeries.
	expected name: #average.
	expected keys: df columnNames.
	
	actual := df average.
	self assert: actual closeTo: expected.
]

{ #category : #initialization }
DataFrameStatsTests >> testFirstQuartile [

	| expected actual |
	
	expected := { 5.1 . 2.8 . 1.6 . 0.3 . Float nan } asDataSeries.
	expected name: #firstQuartile.
	expected keys: df columnNames.
	
	actual := df firstQuartile.
	self assert: actual equals: expected.
]

{ #category : #initialization }
DataFrameStatsTests >> testInterquartileRange [

	| expected actual |
	
	expected := { 1.3 . 0.5 . 3.5 . 1.5 . Float nan } asDataSeries.
	expected name: #interquartileRange.
	expected keys: df columnNames.
	
	actual := df interquartileRange.
	self assert: actual closeTo: expected.
]

{ #category : #initialization }
DataFrameStatsTests >> testMax [

	| expected actual |
	
	expected := { 7.9 . 4.4 . 6.9 . 2.5 . Float nan } asDataSeries.
	expected name: #max.
	expected keys: df columnNames.
	
	actual := df max.
	self assert: actual equals: expected.
]

{ #category : #initialization }
DataFrameStatsTests >> testMean [

	| expected actual |
	
	expected := { 5.84 . 3.05 . 3.76 . 1.2 . Float nan } asDataSeries.
	expected name: #mean.
	expected keys: df columnNames.
	
	actual := df mean.
	self assert: actual equals: expected.
]

{ #category : #initialization }
DataFrameStatsTests >> testMedian [

	| expected actual |
	
	expected := { 5.8 . 3 . 4.3 . 1.3 . Float nan } asDataSeries.
	expected name: #median.
	expected keys: df columnNames.
	
	actual := df median.
	self assert: actual equals: expected.
]

{ #category : #initialization }
DataFrameStatsTests >> testMin [

	| expected actual |
	
	expected := { 4.3 . 2 . 1 . 0.1 . Float nan } asDataSeries.
	expected name: #min.
	expected keys: df columnNames.
	
	actual := df min.
	self assert: actual equals: expected.
]

{ #category : #initialization }
DataFrameStatsTests >> testMode [

	| expected actual |
	
	expected := { 5 . 3 . 1.5 . 0.2 . Float nan } asDataSeries.
	expected name: #mode.
	expected keys: df columnNames.
	
	actual := df mode.
	self assert: actual equals: expected.
]

{ #category : #initialization }
DataFrameStatsTests >> testRange [

	| expected actual |
	
	expected := { 3.6 . 2.4 . 5.9 . 2.4 . Float nan } asDataSeries.
	expected name: #range.
	expected keys: df columnNames.
	
	actual := df range.
	self assert: actual closeTo: expected.
]

{ #category : #initialization }
DataFrameStatsTests >> testStdev [

	| expected actual |
	
	expected := { 0.82806 . 0.43359 . 1.76442 . 0.76316 . Float nan } asDataSeries.
	expected name: #stdev.
	expected keys: df columnNames.
	
	actual := df stdev.
	self assert: actual closeTo: expected.
]

{ #category : #initialization }
DataFrameStatsTests >> testThirdQuartile [

	| expected actual |
	
	expected := { 6.4 . 3.3 . 5.1 . 1.8 . Float nan } asDataSeries.
	expected name: #thirdQuartile.
	expected keys: df columnNames.
	
	actual := df thirdQuartile.
	self assert: actual equals: expected.
]

{ #category : #initialization }
DataFrameStatsTests >> testVariance [

	| expected actual |
	
	expected := { 0.68569 . 0.188 . 3.11317 . 0.58241 . Float nan } asDataSeries.
	expected name: #variance.
	expected keys: df columnNames.
	
	actual := df variance.
	self assert: actual closeTo: expected.
]
