Class {
	#name : 'DataFrameAbstractSqliteWriter',
	#superclass : 'DataFrameWriter',
	#instVars : [
		'tableName'
	],
	#category : 'DataFrame-IO-Sqlite',
	#package : 'DataFrame-IO-Sqlite'
}

{ #category : 'helpers' }
DataFrameAbstractSqliteWriter >> insertQueryForColumns: aSequence [
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
DataFrameAbstractSqliteWriter >> tableName [

	^ tableName
]

{ #category : 'accessing' }
DataFrameAbstractSqliteWriter >> tableName: anObject [

	tableName := anObject
]
