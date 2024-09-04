Class {
	#name : 'DataFrameSqliteReader',
	#superclass : 'DataFrameReader',
	#category : 'DataFrame-IO-Sqlite',
	#package : 'DataFrame-IO-Sqlite'
}

{ #category : 'reading' }
DataFrameSqliteReader >> readFrom: aSqliteCursor [
	"Read all rows from cursor, stuff them into a new dataframe with columns of same name"

	| cols |
	cols := aSqliteCursor columnNames. "need to grab columns before exhausting the cursor"
	^ DataFrame withRows: aSqliteCursor rows columnNames: cols
]
