Class {
	#name : #DataGrouped,
	#superclass : #Object,
	#instVars : [
		'groups'
	],
	#category : #'DataFrame-Core'
}

{ #category : #private }
DataGrouped >> apply: aBlock [

	self subclassResponsibility
]

{ #category : #private }
DataGrouped >> average [

	^ self apply: [ :eachGroup | eachGroup average ]
]

{ #category : #private }
DataGrouped >> count [

	^ self apply: [ :eachGroup | eachGroup size ]
]

{ #category : #accessing }
DataGrouped >> groups [

	^ groups
]

{ #category : #private }
DataGrouped >> max [

	^ self apply: [ :eachGroup | eachGroup max ]
]

{ #category : #private }
DataGrouped >> min [

	^ self apply: [ :eachGroup | eachGroup min ]
]

{ #category : #private }
DataGrouped >> sum [

	^ self apply: [ :eachGroup | eachGroup sum ]
]
