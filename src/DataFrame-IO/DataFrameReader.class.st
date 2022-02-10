Class {
	#name : #DataFrameReader,
	#superclass : #Object,
	#instVars : [
		'columnTypes'
	],
	#category : #'DataFrame-IO'
}

{ #category : #accessing }
DataFrameReader >> columnTypes [

	^ columnTypes
]

{ #category : #accessing }
DataFrameReader >> columnTypes: columnTypeDefinition [
	"column type definition can be a collection of blocks that take a string as an argument
	 and convert it to another object.
	"

	columnTypes := columnTypeDefinition.
]

{ #category : #reading }
DataFrameReader >> readFrom: aLocation [
	"Read data frame from a given location which can be a file reference, a database connection, or something else (depending on the implementation of subclass)"
	self subclassResponsibility
]
