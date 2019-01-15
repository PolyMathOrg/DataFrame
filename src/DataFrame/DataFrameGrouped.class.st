Class {
	#name : #DataFrameGrouped,
	#superclass : #DataGrouped,
	#category : 'DataFrame-Core-Base'
}

{ #category : #'as yet unclassified' }
DataFrameGrouped class >> group: aDataFrame by: aSeries [

	^ self new split: aDataFrame by: aSeries
]

{ #category : #private }
DataFrameGrouped >> apply: aBlock [
	
	| colNames numberOfRows numberOfColumns result |
	
	colNames := (groups at: 1) columnNames.
	
	numberOfRows := groups size.
	numberOfColumns := colNames size.
	
	result := DataFrame new: (numberOfRows @ numberOfColumns).
	result rowNames: groups keys.
	result columnNames: colNames.
	
	groups doWithIndex: [ :df :i |
		1 to: colNames size do: [ :j |
			result at: i at: j put:
				(aBlock value: (df columnAt: j)) ] ].
		
	^ result
]

{ #category : #printing }
DataFrameGrouped >> printOn: aStream [

	super printOn: aStream.
	aStream cr.
	
	groups doWithIndex: [ :eachDataFrame :i |
		aStream
			nextPutAll: (groups keys at: i) asString;
			nextPutAll: ': '.
		eachDataFrame printOn: aStream.
		
		i = groups size
			ifFalse: [ aStream cr ] ] 
]

{ #category : #private }
DataFrameGrouped >> split: aDataFrame by: aSeries [

	| seriesUnique |
	
	aDataFrame numberOfRows = aSeries size
		ifFalse: [ SizeMismatch signal ].
	
	seriesUnique := aSeries unique asArray.
	
	groups := seriesUnique collect: [ :eachUnique |
		| aList df |
		aList := LinkedList new.
		
		aSeries doWithIndex: [ :each :i |
			each = eachUnique 
				ifTrue: [ aList add: (aDataFrame rowAt: i) ] ].
		
		df := DataFrame fromRows: aList.
		df columnNames: aDataFrame columnNames.
		df ].
	
	groups := groups asDataSeries.
	groups keys: seriesUnique.
	
	^ self
]
