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

{ #category : #'*DataFrame' }
Collection >> withSeries: aDataSeries collect: twoArgBlock [ 
	"Collect and return the result of evaluating twoArgBlock with corresponding elements from this collection and aDataSeries."
	| result |
	aDataSeries size = self size ifFalse: [self errorSizeMismatch].
	
	result := aDataSeries species new: self size.
	result name: aDataSeries name.
	
	aDataSeries keys withIndexDo: [ :key :i |
		result at: key put:
		(twoArgBlock
			value: (self at: i)
			value: (aDataSeries at: key))].
	^ result
]
