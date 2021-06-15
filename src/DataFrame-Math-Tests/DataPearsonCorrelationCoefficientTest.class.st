Class {
	#name : #DataPearsonCorrelationCoefficientTest,
	#superclass : #TestCase,
	#category : #'DataFrame-Math-Tests'
}

{ #category : #tests }
DataPearsonCorrelationCoefficientTest >> testBetweenAnd [
	| age income correlation |
	
	age := #(20 30 40 50) asDataSeries.
	income := #(1500 3000 5000 7500) asDataSeries.
	
	correlation := DataPearsonCorrelationCoefficient between: age and: income.
	self assert: correlation closeTo: 0.99380799.
	
]
