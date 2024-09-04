Class {
	#name : 'DataFrameSqliteWriter',
	#superclass : 'DataFrameWriter',
	#instVars : [
		'tableName',
		'columnMappings'
	],
	#category : 'DataFrame-IO-Sqlite',
	#package : 'DataFrame-IO-Sqlite'
}

{ #category : 'writing' }
DataFrameSqliteWriter class >> writeToTable: aString [

	^ self new
		  tableName: aString;
		  yourself
]

{ #category : 'writing' }
DataFrameSqliteWriter class >> writeToTable: aString columnMappings: aCollection [

	^ self new
		  tableName: aString;
		  columnMappings: aCollection;
		  yourself
]

{ #category : 'accessing' }
DataFrameSqliteWriter >> columnMappings [

	^ columnMappings
]

{ #category : 'accessing' }
DataFrameSqliteWriter >> columnMappings: anObject [

	columnMappings := anObject
]

{ #category : 'helpers' }
DataFrameSqliteWriter >> fieldIndicesFor: aDataFrame [
	"gather indices of columns in dataframe (to avoid lookup by field name later, in loop)"

	^ (self getColumnMappings: aDataFrame) collect: [ :m |
		  | sourceName |
		  sourceName := m isAssociation
			                ifTrue: [ m key ]
			                ifFalse: [ m ].
		  aDataFrame columnNames indexOf: sourceName ]
]

{ #category : 'helpers' }
DataFrameSqliteWriter >> getColumnMappings: aDataFrame [

	^ columnMappings ifNil: [ aDataFrame columnNames ]
]

{ #category : 'helpers' }
DataFrameSqliteWriter >> getColumnNames: aDataFrame [

	^ (self getColumnMappings: aDataFrame) collect: [ :m | m value ]
]

{ #category : 'helpers' }
DataFrameSqliteWriter >> insertQueryForColumns: aSequence [
	""
	^ String streamContents: [ :strm |
		strm
			nextPutAll: 'INSERT INTO ';
			nextPutAll: tableName;
			nextPut: $(;
			nextPutAll: (',' join: aSequence);
			nextPutAll: ')VALUES('.
		aSequence do: [ :ignore | strm nextPut: $? ] separatedBy: [ strm nextPut: $, ].
		strm nextPut: $) ]
]

{ #category : 'accessing' }
DataFrameSqliteWriter >> tableName [

	^ tableName
]

{ #category : 'accessing' }
DataFrameSqliteWriter >> tableName: anObject [

	tableName := anObject
]

{ #category : 'writing' }
DataFrameSqliteWriter >> write: aDataFrame to: aSqliteConnection [

	| fieldIndices args stmt |
	fieldIndices := self fieldIndicesFor: aDataFrame.
	args := Array new: fieldIndices size.
	stmt := aSqliteConnection prepare:
		        (self insertQueryForColumns:
			         (self getColumnNames: aDataFrame)).

	1 to: aDataFrame dimensions x do: [ :rowIndex |
		fieldIndices withIndexDo: [ :srcCol :dstCol |
			args at: dstCol put: (aDataFrame contents at: rowIndex at: srcCol) ].
		stmt execute: args ]
]
