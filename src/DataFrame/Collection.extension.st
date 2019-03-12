Extension { #name : #Collection }

{ #category : #'*DataFrame-Core-Base' }
Collection >> ** arg [

	^ self raisedTo: arg
]

{ #category : #'*DataFrame-Core-Base' }
Collection >> asDataSeries [

	^ self as: DataSeries


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
