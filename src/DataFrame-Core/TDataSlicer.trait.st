"
A trait for DataFrame and DataSet slices:
* head
* tail
"
Trait {
	#name : #TDataSlicer,
	#category : 'DataFrame-Core-Base'
}

{ #category : #accessing }
TDataSlicer >> defaultHeadTailSize [

	^ 5
]

{ #category : #accessing }
TDataSlicer >> head [

	^ self head: self defaultHeadTailSize.
]

{ #category : #accessing }
TDataSlicer >> tail [

	^ self tail: (self defaultHeadTailSize).
]

{ #category : #'as yet unclassified' }
TDataSlicer >> unique [

	| rows |
	rows := LinkedList new.
	
	self 
]
