Extension { #name : #Collection }

{ #category : #'*DataFrame-Core-Base' }
Collection >> ** arg [

	^ self raisedTo: arg
]

{ #category : #'*DataFrame-Core-Base' }
Collection >> asDataSeries [
"Converts a collection to Array and constructs a DataSeries from its values"

	^ DataSeries withValues: self asArray.


]

{ #category : #'*DataFrame-Core-Base' }
Collection >> closeTo: aCollection [

	^ (self - aCollection) inject: true into: [ :accum :each |
		accum and: (each closeTo: 0) ].
]

{ #category : #'*DataFrame-Core-Base' }
Collection >> variance [

	^ self stdev squared.
]
