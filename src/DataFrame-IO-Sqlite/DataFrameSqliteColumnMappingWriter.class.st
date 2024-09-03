Class {
	#name : 'DataFrameSqliteColumnMappingWriter',
	#superclass : 'DataFrameAbstractSqliteWriter',
	#instVars : [
		'columnMappings'
	],
	#category : 'DataFrame-IO-Sqlite',
	#package : 'DataFrame-IO-Sqlite'
}

{ #category : 'writing' }
DataFrameSqliteColumnMappingWriter class >> writeToTable: aString columnMappings: aCollection [

	^ self new
		  tableName: aString;
		  columnMappings: aCollection;
		  yourself
]

{ #category : 'accessing' }
DataFrameSqliteColumnMappingWriter >> columnMappings [

	^ columnMappings
]

{ #category : 'accessing' }
DataFrameSqliteColumnMappingWriter >> columnMappings: anObject [

	columnMappings := anObject
]

{ #category : 'writing' }
DataFrameSqliteColumnMappingWriter >> write: aDataFrame to: aSqliteConnection [

	| fieldIndices args dfCols tblCols stmt nCols |
	nCols := columnMappings size.
	dfCols := aDataFrame columnNames.
	fieldIndices := columnMappings collect: [ :m |
		                dfCols indexOf: (m isAssociation
				                 ifTrue: [ m key ]
				                 ifFalse: [ m ]) ].
	tblCols := columnMappings collect: [ :m | m value ].
	args := Array new: fieldIndices size.

	stmt := aSqliteConnection prepare:
		        (self insertQueryForColumns: tblCols).

	aDataFrame do: [ :r |
		| row |
		row := r asArray.
		1 to: nCols do: [ :i |
			| rowVal |
			rowVal := row at: (fieldIndices at: i).
			args at: i put: rowVal ].
		stmt execute: args ]
]
