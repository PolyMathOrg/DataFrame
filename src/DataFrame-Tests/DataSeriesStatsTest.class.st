Class {
	#name : #DataSeriesStatsTest,
	#superclass : #TestCase,
	#instVars : [
		'series'
	],
	#category : #'DataFrame-Tests'
}

{ #category : #initialization }
DataSeriesStatsTest >> setUp [

	series := #(3 7 6 20 8 9 8 10 15 13 16) asDataSeries.
]

{ #category : #tests }
DataSeriesStatsTest >> testAverage [

	self assert: series average equals: (115/11).
]

{ #category : #tests }
DataSeriesStatsTest >> testFirstQuartile [

	self assert: series firstQuartile equals: 7.
]

{ #category : #tests }
DataSeriesStatsTest >> testInterquartileRange [

	self assert: series interquartileRange equals: 8.
]

{ #category : #tests }
DataSeriesStatsTest >> testMax [

	self assert: series max equals: 20.
]

{ #category : #tests }
DataSeriesStatsTest >> testMedian [

	self assert: series median equals: 9.
]

{ #category : #tests }
DataSeriesStatsTest >> testMin [

	self assert: series min equals: 3.
]

{ #category : #tests }
DataSeriesStatsTest >> testMode [

	self assert: series mode equals: 8.
]

{ #category : #tests }
DataSeriesStatsTest >> testQuantile [
	
	self assert: (series quantile: 0) equals: 3.
	self assert: (series quantile: 10) equals: 6.
	self assert: (series quantile: 25) equals: 7.
	self assert: (series quantile: 50) equals: 9.
	self assert: (series quantile: 75) equals: 15.
	self assert: (series quantile: 100) equals: 20.
]

{ #category : #tests }
DataSeriesStatsTest >> testQuartile [
	
	self assert: (series quartile: 0) equals: 3.
	self assert: (series quartile: 1) equals: 7.
	self assert: (series quartile: 2) equals: 9.
	self assert: (series quartile: 3) equals: 15.
	self assert: (series quartile: 4) equals: 20.
]

{ #category : #tests }
DataSeriesStatsTest >> testRange [

	self assert: series range equals: 17.
]

{ #category : #tests }
DataSeriesStatsTest >> testStdev [

	self assert: series stdev closeTo: 5.00727.
]

{ #category : #tests }
DataSeriesStatsTest >> testSummary [

	| expected actual |
	
	expected := { 3.0 . 7.0 . 9.0 . (115 / 11) asFloat . 15.0 . 20.0 } asDataSeries.
	expected keys: #(Min '1st Qu.' Median Average '3rd Qu.' Max).
	actual := series summary collect: #asFloat.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
DataSeriesStatsTest >> testThirdQuartile [

	self assert: series thirdQuartile equals: 15.
]

{ #category : #tests }
DataSeriesStatsTest >> testVariance [

	self assert: series variance closeTo: 25.07273.
]
