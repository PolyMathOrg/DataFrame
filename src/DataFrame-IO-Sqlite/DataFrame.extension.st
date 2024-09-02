Extension { #name : 'DataFrame' }

{ #category : '*DataFrame-IO-Sqlite' }
DataFrame class >> readFromSqliteCursor: aSqliteCursor [
	"Convenience shortcut for SQLite3Cursor => DataFrame"
	^ self readFrom: aSqliteCursor using: DataFrameSqliteReader new
]
