Extension { #name : #Collection }

{ #category : #'*DataFrame-Core-Base' }
Collection >> ** arg [

	^ self raisedTo: arg
]

{ #category : #'*DataFrame' }
Collection >> asDataFrame [

	| numberOfRows numberOfColumns dataFrame |
	numberOfRows := self size.
	numberOfColumns := 0.
	numberOfRows = 0 ifFalse: [
		numberOfColumns := (self collect: #size) max ].
	dataFrame := DataFrame new: numberOfRows @ numberOfColumns.

	1 to: numberOfRows do: [ :rowIndex |
		| row |
		row := self at: rowIndex.
		1 to: numberOfColumns do: [ :colIndex |
			| value |
			value := row at: colIndex ifAbsent: [ nil ].
			dataFrame at: rowIndex at: colIndex put: value ] ].


	^ dataFrame
]

{ #category : #'*DataFrame-Core-Base' }
Collection >> asDataSeries [

	^ DataSeries newFrom: self
]

{ #category : #'*DataFrame-Core-Base' }
Collection >> closeTo: aCollection [

	^ (self - aCollection) inject: true into: [ :accum :each |
		accum and: (each closeTo: 0) ]
]

{ #category : #'*DataFrame-Core-Base' }
Collection >> variance [

	^ self stdev squared
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
