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

{ #category : 'helpers' }
DataFrameSqliteColumnMappingWriter >> fieldIndicesFor: aDataFrame [
	"gather indices of columns in dataframe (to avoid lookup by field name later, in loop)"

	^ columnMappings collect: [ :m |
		  | sourceName |
		  sourceName := m isAssociation
			                ifTrue: [ m key ]
			                ifFalse: [ m ].
		  aDataFrame columnNames indexOf: sourceName ]
]

{ #category : 'writing' }
DataFrameSqliteColumnMappingWriter >> write: aDataFrame to: aSqliteConnection [

	| fieldIndices args stmt |
	fieldIndices := self fieldIndicesFor: aDataFrame.
	args := Array new: fieldIndices size.
	stmt := aSqliteConnection prepare: (self insertQueryForColumns:
			         (columnMappings collect: [ :m | m value ])).

	1 to: aDataFrame dimensions x do: [ :rowIndex |
		fieldIndices withIndexDo: [ :srcCol :dstCol |
			args at: dstCol put: (aDataFrame contents at: rowIndex at: srcCol) ].
		stmt execute: args ]
]
