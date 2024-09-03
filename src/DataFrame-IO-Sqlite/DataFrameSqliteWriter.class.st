Class {
	#name : 'DataFrameSqliteWriter',
	#superclass : 'DataFrameWriter',
	#instVars : [
		'tableName',
		'columnNames'
	],
	#category : 'DataFrame-IO-Sqlite',
	#package : 'DataFrame-IO-Sqlite'
}

{ #category : 'instance creation' }
DataFrameSqliteWriter class >> writeToTable: aString [

	^ self new
		  tableName: aString;
		  yourself
]

{ #category : 'instance creation' }
DataFrameSqliteWriter class >> writeToTable: aString columnNames: aCollection [

	^ self new
		  tableName: aString;
		  columnNames: aCollection;
		  yourself
]

{ #category : 'accessing' }
DataFrameSqliteWriter >> columnNames [

	^ columnNames
]

{ #category : 'accessing' }
DataFrameSqliteWriter >> columnNames: anObject [

	columnNames := anObject
]

{ #category : 'helpers' }
DataFrameSqliteWriter >> getColumnNamesFor: aDataFrame [

	columnNames ifNil: [ ^ aDataFrame columnNames ].
	columnNames size ~= aDataFrame columns size ifTrue: [
		self error:
			'Column count mismatch (Writer columns <=> DataFrame columns)' ].
	^ columnNames
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

	| stmt |
	stmt := aSqliteConnection prepare:
		        (self insertQueryForColumns:
			         (self getColumnNamesFor: aDataFrame)).
	aDataFrame do: [ :row | stmt execute: row asArray ]
]
