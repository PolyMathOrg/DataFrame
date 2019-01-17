Class {
	#name : #DataSeriesStatsTests,
	#superclass : #TestCase,
	#instVars : [
		'series'
	],
	#category : 'DataFrame-Tests'
}

{ #category : #initialization }
DataSeriesStatsTests >> setUp [

	series := #(3 7 6 20 8 9 8 10 15 13 16) asDataSeries.
]

{ #category : #tests }
DataSeriesStatsTests >> testAverage [

	self assert: series average equals: (115/11).
]

{ #category : #tests }
DataSeriesStatsTests >> testFirstQuartile [

	self assert: series firstQuartile equals: 7.
]

{ #category : #tests }
DataSeriesStatsTests >> testInterquartileRange [

	self assert: series interquartileRange equals: 8.
]

{ #category : #tests }
DataSeriesStatsTests >> testMax [

	self assert: series max equals: 20.
]

{ #category : #tests }
DataSeriesStatsTests >> testMean [

	self assert: series mean asFloat equals: 10.45.
]

{ #category : #tests }
DataSeriesStatsTests >> testMedian [

	self assert: series median equals: 9.
]

{ #category : #tests }
DataSeriesStatsTests >> testMin [

	self assert: series min equals: 3.
]

{ #category : #tests }
DataSeriesStatsTests >> testMode [

	self assert: series mode equals: 8.
]

{ #category : #tests }
DataSeriesStatsTests >> testQuantile [
	
	self assert: (series quantile: 0) equals: 3.
	self assert: (series quantile: 10) equals: 6.
	self assert: (series quantile: 25) equals: 7.
	self assert: (series quantile: 50) equals: 9.
	self assert: (series quantile: 75) equals: 15.
	self assert: (series quantile: 100) equals: 20.
]

{ #category : #tests }
DataSeriesStatsTests >> testQuartile [
	
	self assert: (series quartile: 0) equals: 3.
	self assert: (series quartile: 1) equals: 7.
	self assert: (series quartile: 2) equals: 9.
	self assert: (series quartile: 3) equals: 15.
	self assert: (series quartile: 4) equals: 20.
]

{ #category : #tests }
DataSeriesStatsTests >> testRange [

	self assert: series range equals: 17.
]

{ #category : #tests }
DataSeriesStatsTests >> testStdev [

	self assert: series stdev closeTo: 5.00727.
]

{ #category : #tests }
DataSeriesStatsTests >> testSummary [

	| expected actual |
	
	expected := { 3 . 7 . 9 . 209/20 . 15 . 20 } asDataSeries.
	expected keys: #(Min '1st Qu.' Median Mean '3rd Qu.' Max).
	actual := series summary.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSeriesStatsTests >> testThirdQuartile [

	self assert: series thirdQuartile equals: 15.
]

{ #category : #tests }
DataSeriesStatsTests >> testVariance [

	self assert: series variance closeTo: 25.07273.
]
