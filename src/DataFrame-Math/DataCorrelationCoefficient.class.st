Class {
	#name : #DataCorrelationCoefficient,
	#superclass : #Object,
	#category : #'DataFrame-Math'
}

{ #category : #comparing }
DataCorrelationCoefficient class >> between: x and: y [
	"Calcualte the correlation coefficient between two data series"
	self subclassResponsibility
]
