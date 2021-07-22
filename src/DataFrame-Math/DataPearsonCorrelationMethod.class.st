Class {
	#name : #DataPearsonCorrelationMethod,
	#superclass : #DataCorrelationMethod,
	#category : #'DataFrame-Math'
}

{ #category : #comparing }
DataPearsonCorrelationMethod class >> between: x and: y [
	"Calcualte the Pearson correlation coefficient between two data series"
	
	| xDeviation yDeviation |
	
	x size = y size ifFalse: [
		SizeMismatch signal: 'Correlation can not be calculated for two series of different size' ].
	
	xDeviation := x - x average.
	yDeviation := y - y average.
	
	^ (xDeviation * yDeviation) sum / ((xDeviation ** 2) sum * (yDeviation ** 2) sum) sqrt.
	
	
]
