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
	^ groups collect: [ :eachGroup |
		aBlock value: eachGroup ].
]

{ #category : #printing }
DataSeriesGrouped >> printOn: aStream [

	super printOn: aStream.
	aStream cr.

	groups withIndexDo: [ :eachGroup :i |
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
	
	secondUnique := secondSeries uniqueValues asArray.
	
	groups := secondUnique collect: [ :eachUnique |
		| aList |
		aList := LinkedList new.
		
		secondSeries withIndexDo: [ :eachSecond :i |
			eachSecond = eachUnique 
				ifTrue: [ aList add: (firstSeries atIndex: i) ] ].
		
		aList asDataSeries ].
	
	groups := DataSeries
		withKeys: secondUnique
		values: groups asDataSeries
		name: firstSeries name.
	
	^ self
]
