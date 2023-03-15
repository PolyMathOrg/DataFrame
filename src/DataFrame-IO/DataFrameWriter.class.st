Class {
	#name : #DataFrameWriter,
	#superclass : #Object,
	#category : #'DataFrame-IO-Core'
}

{ #category : #writing }
DataFrameWriter >> write: aDataFrame to: aLocation [
	"Write data frame to a given location which can be a file reference, a database connection, or something else (depending on the implementation of subclass)"
	self subclassResponsibility
]
