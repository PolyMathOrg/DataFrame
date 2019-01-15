"
I am  the internal representation of a DataSeries. I store the data very efficiently and allow you to access it very quickly. 
"
Class {
	#name : #DataSeriesInternal,
	#superclass : #SequenceableCollection,
	#instVars : [
		'contents'
	],
	#category : #'DataFrame-Core'
}

{ #category : #'instance creation' }
DataSeriesInternal class >> fromArray: anArray [

	^ self new initializeWithArray: anArray.
]

{ #category : #'instance creation' }
DataSeriesInternal class >> new: aNumber [

	^ self new initialize: aNumber.
	
]

{ #category : #comparing }
DataSeriesInternal >> = other [

	((other class == self class
			or: [ other isKindOf: Array ])
			and: [ other size = self size ])
		ifFalse: [ ^ false ].
		
	1 to: self size do: [ :i |
		(self at: i) = (other at: i)
			ifFalse: [ ^ false ] ].
		
	^ true.
		
]

{ #category : #adding }
DataSeriesInternal >> add: value [

	contents := contents copyWith: value.
]

{ #category : #accessing }
DataSeriesInternal >> at: aNumber [

	^ contents at: aNumber.
]

{ #category : #accessing }
DataSeriesInternal >> at: aNumber ifAbsent: aBlock [

	^ contents at: aNumber ifAbsent: aBlock.
]

{ #category : #accessing }
DataSeriesInternal >> at: aNumber put: value [

	contents at: aNumber put: value.
]

{ #category : #initialization }
DataSeriesInternal >> initialize [

	super initialize.
	contents := Array new.
	^ self.
]

{ #category : #initialization }
DataSeriesInternal >> initialize: aNumber [

	contents := Array new: aNumber.
	^ self.
]

{ #category : #initialization }
DataSeriesInternal >> initializeWithArray: anArray [

	anArray isArray
		ifFalse: [ Error signal:
			'Only an instance of Array can be accepted as an argument' ].

	contents := anArray.
	^ self.
]

{ #category : #copying }
DataSeriesInternal >> postCopy [

	contents := contents copy.
]

{ #category : #printing }
DataSeriesInternal >> printOn: aStream [

	contents printOn: aStream.
]

{ #category : #removing }
DataSeriesInternal >> removeAt: aNumber [

	contents := contents copyWithoutIndex: aNumber.
]

{ #category : #accessing }
DataSeriesInternal >> size [

	^ contents size.
]
