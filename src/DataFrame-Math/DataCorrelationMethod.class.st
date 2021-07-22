Class {
	#name : #DataCorrelationMethod,
	#superclass : #Object,
	#category : #'DataFrame-Math'
}

{ #category : #comparing }
DataCorrelationMethod class >> between: x and: y [
	"Calcualte the correlation coefficient between two data series"
	self subclassResponsibility
]
