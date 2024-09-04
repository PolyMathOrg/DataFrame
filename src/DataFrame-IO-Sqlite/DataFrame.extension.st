Extension { #name : 'DataFrame' }

{ #category : '*DataFrame-IO-Sqlite' }
DataFrame class >> readFromSqliteCursor: aSqliteCursor [
	"Convenience shortcut for SQLite3Cursor => DataFrame"
	^ self readFrom: aSqliteCursor using: DataFrameSqliteReader new
]

{ #category : '*DataFrame-IO-Sqlite' }
DataFrame >> writeToSqlite: aSqlite3Connection tableName: aString [

	| writer |
	writer := DataFrameSqliteWriter writeToTable: aString.
	self writeTo: aSqlite3Connection using: writer
]

{ #category : '*DataFrame-IO-Sqlite' }
DataFrame >> writeToSqlite: aSqlite3Connection tableName: aString columnMappings: aCollection [

	| writer |
	writer := DataFrameSqliteWriter 
		          writeToTable: aString
		          columnMappings: aCollection.
	self writeTo: aSqlite3Connection using: writer
]

{ #category : '*DataFrame-IO-Sqlite' }
DataFrame >> writeToSqlite: aSqlite3Connection tableName: aString columnNames: aCollection [

	| writer |
	writer := DataFrameSqliteWriter
		          writeToTable: aString
		          columnMappings: aCollection.
	self writeTo: aSqlite3Connection using: writer
]
