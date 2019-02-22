Class {
	#name : #DataFrameStatsTests,
	#superclass : #TestCase,
	#instVars : [
		'df'
	],
	#category : #'DataFrame-Tests'
}

{ #category : #initialization }
DataFrameStatsTests >> setUp [

	df := DataFrame fromRows: #(
		(5.1 3.5 1.4 0.2 setosa)
		(4.9 3 1.4 0.2 setosa)
		(4.7 3.2 1.3 0.2 setosa)
		(7 3.2 4.7 1.4 versicolor)
		(6.4 3.2 4.5 1.5 versicolor)
		(6.9 3.1 4.9 1.5 versicolor)
		(6.3 3.3 6 2.5 virginica)
		(5.8 2.7 5.1 1.9 virginica)
		(7.1 3 5.9 2.1 virginica)).
		
	df columnNames: #(sepalLength sepalWidth petalLength petalWidth species).
]

{ #category : #initialization }
DataFrameStatsTests >> testAverage [

	| expected actual |
	
	expected := { 6.022222 . 3.133333 . 3.911111 . 1.277778 . Float nan } asDataSeries.
	expected name: #average.
	expected keys: df columnNames.
	
	actual := df average.
	self assert: actual closeTo: expected.
]

{ #category : #initialization }
DataFrameStatsTests >> testFirstQuartile [

	| expected actual |
	
	expected := { 5.1 . 3 . 1.4 . 0.2 . Float nan } asDataSeries.
	expected name: #firstQuartile.
	expected keys: df columnNames.
	
	actual := df firstQuartile.
	self assert: actual equals: expected.
]

{ #category : #initialization }
DataFrameStatsTests >> testInterquartileRange [

	| expected actual |
	
	expected := { 1.8 . 0.2 . 3.7 . 1.7 . Float nan } asDataSeries.
	expected name: #interquartileRange.
	expected keys: df columnNames.
	
	actual := df interquartileRange.
	self assert: actual closeTo: expected.
]

{ #category : #initialization }
DataFrameStatsTests >> testMax [

	| expected actual |
	
	expected := { 7.1 . 3.5 . 6 . 2.5 . Float nan } asDataSeries.
	expected name: #max.
	expected keys: df columnNames.
	
	actual := df max.
	self assert: actual equals: expected.
]

{ #category : #initialization }
DataFrameStatsTests >> testMean [

	| expected actual |
	
	expected := { 6.022222 . 3.133333 . 3.911111 . 1.277778 . Float nan } asDataSeries.
	expected name: #mean.
	expected keys: df columnNames.
	
	actual := df mean.
	self assert: actual equals: expected.
]

{ #category : #initialization }
DataFrameStatsTests >> testMedian [

	| expected actual |
	
	expected := { 6.3 . 3.2 . 4.7 . 1.5 . Float nan } asDataSeries.
	expected name: #median.
	expected keys: df columnNames.
	
	actual := df median.
	self assert: actual equals: expected.
]

{ #category : #initialization }
DataFrameStatsTests >> testMin [

	| expected actual |
	
	expected := { 4.7 . 2.7 . 1.3 . 0.2 . Float nan } asDataSeries.
	expected name: #min.
	expected keys: df columnNames.
	
	actual := df min.
	self assert: actual equals: expected.
]

{ #category : #initialization }
DataFrameStatsTests >> testMode [

	| expected actual |
	
	expected := { 5.1 . 3.2 . 1.4 . 0.2 . Float nan } asDataSeries.
	expected name: #mode.
	expected keys: df columnNames.
	
	actual := df mode.
	self assert: actual equals: expected.
]

{ #category : #initialization }
DataFrameStatsTests >> testRange [

	| expected actual |
	
	expected := { 2.4 . 0.8 . 4.7 . 2.3 . Float nan } asDataSeries.
	expected name: #range.
	expected keys: df columnNames.
	
	actual := df range.
	self assert: actual closeTo: expected.
]

{ #category : #initialization }
DataFrameStatsTests >> testStdev [

	| expected actual |
	
	expected := { 0.936453 . 0.223607 . 1.971956 . 0.877180 . Float nan } asDataSeries.

	expected name: #stdev.
	expected keys: df columnNames.
	
	actual := df stdev.
	self assert: actual closeTo: expected.
]

{ #category : #initialization }
DataFrameStatsTests >> testThirdQuartile [

	| expected actual |
	
	expected := { 6.9 . 3.2 . 5.1 . 1.9 . Float nan } asDataSeries.
	expected name: #thirdQuartile.
	expected keys: df columnNames.
	
	actual := df thirdQuartile.
	self assert: actual equals: expected.
]

{ #category : #initialization }
DataFrameStatsTests >> testVariance [

	| expected actual |
	
	expected := { 0.876944 . 0.050000 . 3.888611 . 0.769444 . Float nan } asDataSeries.
	expected name: #variance.
	expected keys: df columnNames.
	
	actual := df variance.
	self assert: actual closeTo: expected.
]
