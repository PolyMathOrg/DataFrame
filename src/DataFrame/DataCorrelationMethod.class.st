Class {
	#name : 'DataCorrelationMethod',
	#superclass : 'Object',
	#category : 'DataFrame-Math',
	#package : 'DataFrame',
	#tag : 'Math'
}

{ #category : 'comparing' }
DataCorrelationMethod class >> between: x and: y [
	"Calcualte the correlation coefficient between two data series"
	self subclassResponsibility
]
