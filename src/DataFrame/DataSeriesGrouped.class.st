Class {
	#name : #DataSeriesGrouped,
	#superclass : #DataGrouped,
	#category : #'DataFrame-Core'
}

{ #category : #'as yet unclassified' }
DataSeriesGrouped class >> group: firstSeries by: secondSeries [

	^ self new split: firstSeries by: secondSeries
]

{ #category : #private }
DataSeriesGrouped >> apply: aBlock [

	| result |
	
	result := groups collect: [ :eachGroup |
		aBlock value: eachGroup ].
	
	result := result asDataSeries.
	result keys: groups keys.
	
	^ result
]

{ #category : #printing }
DataSeriesGrouped >> printOn: aStream [

	super printOn: aStream.
	aStream cr.

	groups doWithIndex: [ :eachGroup :i |
		aStream
			nextPutAll: (groups keys at: i) asString;
			nextPutAll: ': '.
		eachGroup printOn: aStream.
		
		i = groups size
			ifFalse: [ aStream cr ] ]
]

{ #category : #private }
DataSeriesGrouped >> split: firstSeries by: secondSeries [

	| secondUnique |
	
	firstSeries size = secondSeries size
		ifFalse: [ SizeMismatch signal ].
	
	secondUnique := secondSeries unique asArray.
	
	groups := secondUnique collect: [ :eachUnique |
		| aList |
		aList := LinkedList new.
		
		secondSeries doWithIndex: [ :eachSecond :i |
			eachSecond = eachUnique 
				ifTrue: [ aList add: (firstSeries at: i) ] ].
		
		aList asDataSeries ].
	
	groups := groups asDataSeries.
	groups keys: secondUnique.
	
	^ self
]
