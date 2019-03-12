Extension { #name : #DataFrame }

{ #category : #'*DataFrame-IO' }
DataFrame class >> readFrom: aLocation using: aDataFrameReader [
	"Read data frame from a given location using a given DataFrameReader. Location can be a file reference, a database connection, or something else (depending on the implementation of the reader)"
	^ aDataFrameReader readFrom: aLocation
]

{ #category : #'*DataFrame-IO' }
DataFrame class >> readFromCsv: aFileReference [ 
	| reader |
	reader := DataFrameCsvReader new.
	^ reader readFrom: aFileReference.
]

{ #category : #'*DataFrame-IO' }
DataFrame class >> readFromCsv: aFileReference withSeparator: aSeparator [ 
	| reader |
	reader := DataFrameCsvReader new.
	reader separator: aSeparator.
	^ reader readFrom: aFileReference.
]

{ #category : #'*DataFrame-IO' }
DataFrame class >> readFromCsvWithRowNames: aFileReference [ 
	| reader |
	reader := DataFrameCsvReader new.
	reader includeRowNames: true.
	^ reader readFrom: aFileReference.
]

{ #category : #'*DataFrame-IO' }
DataFrame class >> readFromCsvWithRowNames: aFileReference separator: aSeparator [
	| reader |
	reader := DataFrameCsvReader new.
	reader includeRowNames: true.
	reader separator: aSeparator.
	^ reader readFrom: aFileReference.
]

{ #category : #'*DataFrame-IO' }
DataFrame >> writeTo: aLocation using: aDataFrameWriter [
	"Write data frame to a given location using a given DataFrameWriter. Location can be a file reference, a database connection, or something else (depending on the implementation of the writer)"
	aDataFrameWriter write: self to: aLocation
]

{ #category : #'*DataFrame-IO' }
DataFrame >> writeToCsv: aFileReference [
	| writer |
	writer := DataFrameCsvWriter new.
	self writeTo: aFileReference using: writer.
]

{ #category : #'*DataFrame-IO' }
DataFrame >> writeToCsv: aFileReference withSeparator: aSeparator [
	| writer |
	writer := DataFrameCsvWriter new.
	writer separator: aSeparator.
	self writeTo: aFileReference using: writer.
]
