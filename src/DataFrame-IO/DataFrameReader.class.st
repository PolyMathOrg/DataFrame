Class {
	#name : #DataFrameReader,
	#superclass : #Object,
	#category : #'DataFrame-IO'
}

{ #category : #reading }
DataFrameReader >> readFrom: aLocation [
	"Read data frame from a given location which can be a file reference, a database connection, or something else (depending on the implementation of subclass)"
	self subclassResponsibility
]
