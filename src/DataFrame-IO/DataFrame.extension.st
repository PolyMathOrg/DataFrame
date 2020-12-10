Extension { #name : #DataFrame }

{ #category : #'*DataFrame-IO' }
DataFrame class >> readFrom: aLocation using: aDataFrameReader [
	"Read data frame from a given location using a given DataFrameReader. Location can be a file reference, a database connection, or something else (depending on the implementation of the reader)"
	^ aDataFrameReader readFrom: aLocation
]

{ #category : #'*DataFrame-IO' }
DataFrame class >> readFrom: aLocation using: aDataFrameReader missingValuesString: aSet [
	"Read data frame from a given location using a given DataFrameReader. Location can be a file reference, a database connection, or something else (depending on the implementation of the reader).
	 Replaces the elements of aSet present in dataframe with nil"
	
	| df infer |
	
	"The readFrom method will infer types by default but we want this to happen after we convert things to nil
	 so here we temporarily force it to false so that we can infer later 
	"
	aDataFrameReader shouldInferTypes ifTrue: [ infer := true  ].
	aDataFrameReader shouldInferTypes: false.
	df := aDataFrameReader readFrom: aLocation.
	
	df contents replaceMissingValuesStrings: aSet.
	infer ifTrue: [  
		DataFrameTypeDetector new detectTypesAndConvert: df].
	^ df
]

{ #category : #'*DataFrame-IO' }
DataFrame class >> readFromCsv: aFileReference [ 
	| reader |
	reader := DataFrameCsvReader new.
	^ self readFrom: aFileReference using: reader.
]

{ #category : #'*DataFrame-IO' }
DataFrame class >> readFromCsv: aFileReference withSeparator: aSeparator [ 
	| reader |
	reader := DataFrameCsvReader new.
	reader separator: aSeparator.
	^ self readFrom: aFileReference using: reader
]

{ #category : #'*DataFrame-IO' }
DataFrame class >> readFromCsvWithRowNames: aFileReference [ 
	| reader |
	reader := DataFrameCsvReader new.
	reader includeRowNames: true.
	^ self readFrom: aFileReference using: reader
]

{ #category : #'*DataFrame-IO' }
DataFrame class >> readFromCsvWithRowNames: aFileReference separator: aSeparator [
	| reader |
	reader := DataFrameCsvReader new.
	reader includeRowNames: true.
	reader separator: aSeparator.
	^ self readFrom: aFileReference using: reader
]

{ #category : #'*DataFrame-IO' }
DataFrame class >> readFromJson: aFileReference [ 
	| reader |
	reader := DataFrameJsonReader new.
	^ self readFrom: aFileReference using: reader.
]

{ #category : #'*DataFrame-IO' }
DataFrame class >> readFromJson: aFileReference orient: orient [
	| reader |
	reader := DataFrameJsonReader new.
	reader orient: orient.
	^ self readFrom: aFileReference using: reader.
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

{ #category : #'*DataFrame-IO' }
DataFrame >> writeToJson: aFileReference [
	| writer |
	writer := DataFrameJsonWriter new.
	self writeTo: aFileReference using: writer.
]

{ #category : #'*DataFrame-IO' }
DataFrame >> writeToJson: aFileReference orient: orient [
	| writer |
	writer := DataFrameJsonWriter new.
	writer orient: orient.
	self writeTo: aFileReference using: writer.
]

{ #category : #'*DataFrame-IO' }
DataFrame >> writeToPrettyJson: aFileReference [
	| writer |
	writer := DataFrameJsonWriter new.
	writer pretty: true.
	self writeTo: aFileReference using: writer.
]

{ #category : #'*DataFrame-IO' }
DataFrame >> writeToPrettyJson: aFileReference orient: orient [
	| writer |
	writer := DataFrameJsonWriter new.
	writer orient: orient.
	writer pretty: true.
	self writeTo: aFileReference using: writer.
]
