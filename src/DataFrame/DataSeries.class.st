Class {
	#name : #DataSeries,
	#superclass : #OrderedDictionary,
	#instVars : [
		'name'
	],
	#category : #'DataFrame-Core'
}

{ #category : #'instance creation' }
DataSeries class >> newFrom: aCollection [
	"If it's a collection of associations use the superclass implementation"
	^ super newFrom: ((aCollection first respondsTo: #key)
		ifTrue: [ aCollection ]
		ifFalse: [ aCollection collectWithIndex: [ :each :i | i -> each ] ]).
]

{ #category : #'instance creation' }
DataSeries class >> withKeys: keys values: values [
	^ self newFromKeys: keys andValues: values 
]

{ #category : #'instance creation' }
DataSeries class >> withKeys: keys values: values name: aName [
	^ (self withKeys: keys values: values) name: aName; yourself
]

{ #category : #'instance creation' }
DataSeries class >> withValues: values [
	| keys |
	keys := (1 to: values size) asArray. 
	^ self withKeys: keys values: values 
]

{ #category : #'instance creation' }
DataSeries class >> withValues: values name: aName [
	| keys |
	keys := (1 to: values size) asArray. 
	^ (self withKeys: keys values: values) name: aName; yourself
]

{ #category : #'as yet unclassified' }
DataSeries >> atIndex: aNumber [
	^ self at: (self keys at: aNumber)
]

{ #category : #'as yet unclassified' }
DataSeries >> atIndex: aNumber ifAbsent: aBlock [
	^ [ self at: (self keys at: aNumber) ] on: SubscriptOutOfBounds do: aBlock
]

{ #category : #'as yet unclassified' }
DataSeries >> atIndex: aNumber put: aValue [
	^ self at: (self keys at: aNumber) put: aValue
]

{ #category : #accessing }
DataSeries >> defaultName [
	^ '(no name)'
]

{ #category : #initialization }
DataSeries >> initialize [ 
	super initialize.
	name := self defaultName.
]

{ #category : #'as yet unclassified' }
DataSeries >> keys: anArrayOfKeys [
	| keys |
	keys := anArrayOfKeys deepCopy.
	dictionary := self dictionaryClass newFromKeys: keys andValues: self values.
	orderedKeys := keys.
]

{ #category : #accessing }
DataSeries >> name [
	^ name
]

{ #category : #accessing }
DataSeries >> name: anObject [
	name := anObject
]

{ #category : #removing }
DataSeries >> removeAt: aKey [
	^ self removeKey: aKey
]

{ #category : #removing }
DataSeries >> removeAtIndex: aNumber [
	^ self removeAt: (self keys at: aNumber)
]

{ #category : #sorting }
DataSeries >> sort [
	^ self sort: [ :a :b | a value <= b value ]
]

{ #category : #sorting }
DataSeries >> sort: aBlock [
	| sortedAssociations |
	sortedAssociations := self associations sort: aBlock.
	^ sortedAssociations asDataSeries name: self name; yourself
]

{ #category : #sorting }
DataSeries >> sortDescending [
	^ self sort: [ :a :b | a value > b value ]
]

{ #category : #enumerating }
DataSeries >> withIndexCollect: aBlock [
	^ self species newFrom:
		(self associations withIndexCollect: [:each :i |
			each key -> (aBlock value: each value value: i)])
]

{ #category : #enumerating }
DataSeries >> withIndexDo: aBlock [
	self keys withIndexDo: [ :each :i | aBlock value: (self at: each) value: i ]
]

{ #category : #enumerating }
DataSeries >> withKeyCollect: aBlock [
	^ self species newFrom:
		(self associations collect: [:each |
			each key -> (aBlock value: each value value: each key)])
]

{ #category : #enumerating }
DataSeries >> withKeyDo: aBlock [
	self keysDo: [ :each | aBlock value: (self at: each) value: each ]
]
