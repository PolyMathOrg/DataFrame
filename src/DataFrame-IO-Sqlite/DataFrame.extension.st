Extension { #name : 'DataFrame' }

{ #category : '*DataFrame-IO-Sqlite' }
DataFrame class >> readFromSqliteCursor: aSqliteCursor [

	| reader |
	reader := DataFrameSqliteReader new.
	^ self readFrom: aSqliteCursor using: reader
]
