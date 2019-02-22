"
I am a data series, suitable for data analysis.
"
Class {
	#name : #DataSeries,
	#superclass : #SequenceableCollection,
	#traits : 'TDataSlicer',
	#classTraits : 'TDataSlicer classTrait',
	#instVars : [
		'contents',
		'keys',
		'name',
		'type'
	],
	#category : #'DataFrame-Core'
}

{ #category : #'instance creation' }
DataSeries class >> fromArray: anArray [
	
	| series |
	series := self new: anArray size.
	series fillWithValuesOf: anArray.
	^ series.
		
	
]

{ #category : #'instance creation' }
DataSeries class >> fromArray: anArray named: aName [
	
	| series |
	series := self fromArray: anArray.
	series name: aName.
	^ series.
		
	
]

{ #category : #'instance creation' }
DataSeries class >> fromSeries: aSeries [
	
	| series |
	series := self newFrom: aSeries.
	
	series keys: aSeries keys.
	series name: aSeries name.
	series type: aSeries type.
	
	^ series
		
	
]

{ #category : #'instance creation' }
DataSeries class >> named: aString [

	^ self new name: aString
]

{ #category : #'instance creation' }
DataSeries class >> new: aNumber [

	^ self new initialize: aNumber.
	
]

{ #category : #'instance creation' }
DataSeries class >> new: aNumber named: aString [

	^ (self new: aNumber) name: aString
]

{ #category : #comparing }
DataSeries >> = otherSeries [

	(otherSeries isKindOf: DataSeries)
		ifFalse: [ ^ false ].

	"I'm not sure if names should be considered when testing for equality"
	"self name = otherSeries name
		ifFalse: [ ^ false ]."
		
	self type = otherSeries type
		ifFalse: [ ^ false ].
		
	self keys = otherSeries keys
		ifFalse: [ ^ false ].

	^ (1 to: self size) inject: true into: [ :allEqual :i |
		| selfCell otherCell |
		selfCell := self at: i.
		otherCell := otherSeries at: i.
		
		(allEqual and: (selfCell = otherCell))
			ifTrue: [ true ]
			ifFalse: [ 
				(selfCell isNumber and: otherCell isNumber)
					ifFalse: [ false ]
					ifTrue: [ (selfCell isNaN and: otherCell isNaN) ] ] ].
]

{ #category : #adding }
DataSeries >> add: aValue atKey: aKey [

	contents add: aValue.
	keys := keys copyWith: aKey.
	self induceTypeWithNewElement: aValue.
]

{ #category : #converting }
DataSeries >> asDataFrame [

	| df |
	df := DataFrame fromColumns: { self }.
	df columnNames: { self name }.
	df rowNames: self keys.
	^ df
]

{ #category : #converting }
DataSeries >> asDataSeries [

	^ DataSeries newFrom: self.
]

{ #category : #printing }
DataSeries >> asStringTable [

	^ self asDataFrame asStringTable
]

{ #category : #accessing }
DataSeries >> at: aNumber [

	^ contents at: aNumber
]

{ #category : #accessing }
DataSeries >> at: aNumber put: aValue [

	contents at: aNumber put: aValue.
	self induceTypeWithNewElement: aValue.
]

{ #category : #accessing }
DataSeries >> atKey: aKey [

	^ self atKey: aKey ifAbsent: [
		NotFoundError signal:
			'Key ',
			aKey asString,
			' was not found in ',
			self class asString ].
]

{ #category : #accessing }
DataSeries >> atKey: aKey ifAbsent: exceptionBlock [
	
	| index |
	index := self indexOfKey: aKey ifAbsent: exceptionBlock.
		
	"In case contents and keys have different sizes"
	^ contents at: index ifAbsent: exceptionBlock.
]

{ #category : #accessing }
DataSeries >> atKey: aKey put: aValue [

	| index |
	index := keys indexOf: aKey.
	
	index = 0
		"a key was not found - create a new element"
		ifTrue: [
			self add: aValue atKey: aKey ]
		"a key was found - update the value"
		ifFalse: [
			self at: index put: aValue ].
]

{ #category : #statistics }
DataSeries >> average [

	self signalErrorIfNotQuantitative.
	^ super average
]

{ #category : #comparing }
DataSeries >> closeTo: otherSeries [

	(otherSeries isKindOf: DataSeries)
		ifFalse: [ ^ false ].

	"I'm not sure if names should be considered when testing for equality"
	self name = otherSeries name
		ifFalse: [ ^ false ].
		
	self type = otherSeries type
		ifFalse: [ ^ false ].
		
	self keys = otherSeries keys
		ifFalse: [ ^ false ].

	^ (1 to: self size) inject: true into: [ :allEqual :i |
		| selfCell otherCell |
		selfCell := self at: i.
		otherCell := otherSeries at: i.
		
		allEqual and: ((selfCell closeTo: otherCell) or:
			((selfCell isNumber and: otherCell isNumber) and:
			(selfCell isNaN and: otherCell isNaN))) ].
]

{ #category : #enumerating }
DataSeries >> collect: aBlock [

	| series |
	series := super collect: aBlock.
	series name: self name.
	series keys: self keys.
	^ series
]

{ #category : #'as yet unclassified' }
DataSeries >> crossTabulateWith: aSeries [

	| df |
	
	(self size = aSeries size)
		ifFalse: [ SizeMismatch signal ].
	
	"TODO: Rewrite it with DataFrame>>select:"
	df := DataFrame fromRows: 
		(self unique asArray collect: [ :each1 |
			aSeries unique asArray collect: [ :each2 |
				(1 to: self size) inject: 0 into: [ :accum :i |
					(((self at: i) = each1) and: ((aSeries at: i) = each2))
						ifTrue: [ accum + 1 ]
						ifFalse: [ accum ] ] ] ]).
		
	df rowNames: self unique asArray.
	df columnNames: aSeries unique asArray.
	^ df
]

{ #category : #'reflective operations' }
DataSeries >> doesNotUnderstand: aMessage [

	^ self collect: [ :each |
		each
			perform: aMessage selector
			withArguments: aMessage arguments ]
	
]

{ #category : #initialization }
DataSeries >> fillWithValuesOf: anArray [
"Fills a newly created series with values of an array. This method is called from the fromArray: class method. It should only be called after initialize: as it is assumed that the memory was already allocated and the size of the self is equal to the size of array.
This method is private and should not be used in custom applications"

	anArray doWithIndex: [ :each :i |
		contents at: i put: each ].
	
	self induceType.
]

{ #category : #statistics }
DataSeries >> firstQuartile [
	
	self signalErrorIfNotQuantitative.
	^ self quartile: 1
]

{ #category : #statistics }
DataSeries >> frequencyTable [

	| df count proportion |
	
	count := (self groupBy: self) count.
	proportion := count / self size.
	
	df := DataFrame fromColumns:
		{ count . proportion }.
		
	df rowNames: self unique asArray.
	df columnNames: #(Count Proportion).
	
	^ df
]

{ #category : #accessing }
DataSeries >> from: start to: end [

	| series |
	series := ((start to: end) collect: [ :i |
		self at: i]) asDataSeries.
	
	series name: self name.
	series keys: (self keys copyFrom: start to: end).
	^ series.
]

{ #category : #'as yet unclassified' }
DataSeries >> groupBy: aSeries [

	^ DataSeriesGrouped group: self by: aSeries
]

{ #category : #accessing }
DataSeries >> head: aNumber [

	| n |
	
	self size > aNumber
		ifTrue: [ n := aNumber ]
		ifFalse: [ n := self size ].
		
	^ self from: 1 to: n.
]

{ #category : #private }
DataSeries >> indexOfKey: aKey [

	^ self indexOfKey: aKey ifAbsent: [
		NotFoundError signal:
			'Key ',
			aKey asString,
			' was not found in ',
			self class asString ].
]

{ #category : #private }
DataSeries >> indexOfKey: aKey ifAbsent: aBlock [

	| index |
	index := keys indexOf: aKey.
	
	index = 0
		ifTrue: [ ^ aBlock value ].
		
	^ index
]

{ #category : #'as yet unclassified' }
DataSeries >> induceType [
"Determines the least common superclass of all the values inside self and stores this class in type instance variable"

	| inductor |
	inductor := DataTypeInductor new.
	
	type := inductor typeOf: self.
]

{ #category : #'as yet unclassified' }
DataSeries >> induceTypeWithNewElement: aValue [
"Induces type of series given that the new element was added to it"

	self type isNil
		"In case we fill the empty series with elements (e.g. collect)"
		ifTrue: [ type := aValue class ]
		
		"In case we add an element to the existing series"
		ifFalse: [ 
			type := DataTypeInductor new
				leastCommonSuperclassOf: aValue class
				and: self type. ].
]

{ #category : #initialization }
DataSeries >> initialize [

	super initialize.
	contents := DataSeriesInternal new.
	keys := OrderedCollection new.
]

{ #category : #initialization }
DataSeries >> initialize: aNumber [
"Creates an empty DataSeries of a given size. Keys are set to their default values"

	contents := DataSeriesInternal new: aNumber.
	self setDefaultKeys.
	^ self
]

{ #category : #statistics }
DataSeries >> interquartileRange [

	self signalErrorIfNotQuantitative.
	^ self thirdQuartile - self firstQuartile
]

{ #category : #testing }
DataSeries >> isCategorical [

	^ self isQuantitative not
]

{ #category : #testing }
DataSeries >> isQuantitative [

	^ self type inheritsFromOrEqualTo: Number
]

{ #category : #accessing }
DataSeries >> keyAtValue: value [

	^ self keyAtValue: value ifAbsent: [ ValueNotFound signalFor: value ]
]

{ #category : #accessing }
DataSeries >> keyAtValue: value ifAbsent: exceptionBlock [

	| index |
	index := contents indexOf: value.
	
	index = 0
		ifTrue: [ ^ exceptionBlock value ]
		ifFalse: [ ^ keys at: index ].
]

{ #category : #accessing }
DataSeries >> keys [

	^ keys
]

{ #category : #accessing }
DataSeries >> keys: anArray [

	keys := anArray asOrderedCollection.
]

{ #category : #statistics }
DataSeries >> max [

	self signalErrorIfNotQuantitative.
	^ super max
]

{ #category : #statistics }
DataSeries >> mean [

	self signalErrorIfNotQuantitative.
	^ self average round: 2
]

{ #category : #sorting }
DataSeries >> mergeFirst: first middle: middle last: last into: dst by: aBlock [
	"Private. Merge the sorted ranges [first..middle] and [middle+1..last] 
	of the receiver into the range [first..last] of dst."

	| i1 i2 key1 key2 val1 val2 out |
	i1 := first.
	i2 := middle + 1.
	key1 := self keys at: i1.
	key2 := self keys at: i2.
	val1 := self at: i1.
	val2 := self at: i2.
	out := first - 1.  "will be pre-incremented"

	"select 'lower' half of the elements based on comparator"
	[ (i1 <= middle) and: [i2 <= last] ]
		whileTrue: [
			out := out + 1.
			
			(aBlock value: val1 value: val2)
				ifTrue: [
					dst at: out put: val1.
					dst keys at: out put: key1.
					i1 := i1 + 1.
					val1 := self at: i1.
					key1 := self keys at: i1 ]
				
				ifFalse: [
					dst at: out put: val2.
					dst keys at: out put: key2.
					i2 := i2 + 1.
					i2 <= last
						ifTrue: [
							val2 := self at: i2.
							key2 := self keys at: i2 ] ] ].

	"copy the remaining elements"
	i1 <= middle
		ifTrue: [dst replaceFrom: out + 1 to: last with: self startingAt: i1]
		ifFalse: [dst replaceFrom: out + 1 to: last with: self startingAt: i2]
]

{ #category : #statistics }
DataSeries >> min [

	self signalErrorIfNotQuantitative.
	^ super min
]

{ #category : #statistics }
DataSeries >> mode [

	| valueCounts maxCount |
	
	self signalErrorIfNotQuantitative.
	
	valueCounts := (self groupBy: self) count.
	maxCount := valueCounts max.
	
	^ valueCounts keyAtValue: maxCount.
]

{ #category : #accessing }
DataSeries >> name [

	^ name
]

{ #category : #accessing }
DataSeries >> name: aString [

	name := aString
]

{ #category : #copying }
DataSeries >> postCopy [

	keys := keys copy.
	contents := contents copy.
]

{ #category : #printing }
DataSeries >> printOn: aStream [

	| title |
	title := self class name.
	
	aStream
		nextPutAll: (title first isVowel ifTrue: ['an '] ifFalse: ['a ']);
		nextPutAll: title;
		nextPutAll: ' [';
		nextPutAll: self size asString;
		nextPutAll: (self size % 10 = 1 ifTrue: [' item]'] ifFalse: [' items]']);
		nextPutAll: ': ';
		nextPutAll: self type name.
]

{ #category : #statistics }
DataSeries >> quantile: number [
	
	| sortedSeries index |
	
	self signalErrorIfNotQuantitative.
	
	sortedSeries := self asArray sort asDataSeries.
	
	number = 0
		ifTrue: [ ^ sortedSeries first ].
	
	index := (sortedSeries size * (number / 100)) ceiling.
	^ sortedSeries at: index.
]

{ #category : #statistics }
DataSeries >> quartile: number [
	
	self signalErrorIfNotQuantitative.
	^ self quantile: (25 * number)
]

{ #category : #statistics }
DataSeries >> range [

	self signalErrorIfNotQuantitative.
	^ super range
]

{ #category : #removing }
DataSeries >> removeAt: aNumber [

	contents removeAt: aNumber.
	keys := keys copyWithoutIndex: aNumber.
	self induceType.
]

{ #category : #removing }
DataSeries >> removeAtKey: aKey [

	| index |
	index := self indexOfKey: aKey.
	self removeAt: index.
]

{ #category : #accessing }
DataSeries >> replaceFrom: start to: stop with: replacement [

	(replacement isKindOf: self class)
		ifTrue: [ 
			keys
				replaceFrom: start
				to: stop
				with: replacement keys ].
		
	super replaceFrom: start to: stop with: replacement.
]

{ #category : #accessing }
DataSeries >> replaceFrom: start to: stop with: replacement startingAt: repStart [ 

	(replacement isKindOf: self class)
		ifTrue: [ 
			keys
				replaceFrom: start
				to: stop
				with: replacement keys
				startingAt: repStart ].
		
	super replaceFrom: start to: stop with: replacement startingAt: repStart .
]

{ #category : #initialization }
DataSeries >> setDefaultKeys [
"Sets the keys of a series to their default values - to an array of numbers from 1 to self size. This method can be reimplemented by a subclass to provide different default keys"

	keys := (1 to: self size) asOrderedCollection.
]

{ #category : #'error signalling' }
DataSeries >> signalErrorIfNotQuantitative [

	self isQuantitative not
		ifTrue: [
			Error signal:
				'Variable ', self name asString, ' is not quantitative. ',
				'Arithmetic and statistical operations can only be applied ',
				'to quantitative variables' ].
]

{ #category : #accessing }
DataSeries >> size [

	^ contents size
]

{ #category : #sorting }
DataSeries >> sortDescending [
	^ self sortUsing: [ :a :b | a >= b ]
]

{ #category : #sorting }
DataSeries >> sortUsing: aBlock [
	^ self sort: aBlock
]

{ #category : #statistics }
DataSeries >> stdev [

	self signalErrorIfNotQuantitative.
	^ super stdev
]

{ #category : #accessing }
DataSeries >> summary [

	| summary |
	summary := self class new.
	summary name: self name.
	
	summary
		atKey: 'Min' put: self min;
		atKey: '1st Qu.' put: self firstQuartile;
		atKey: 'Median' put: self median;
		atKey: 'Mean' put: self mean;
		atKey: '3rd Qu.' put: self thirdQuartile;
		atKey: 'Max' put: self max.
		
	^ summary
	
]

{ #category : #accessing }
DataSeries >> tail: aNumber [

	| n |
	
	self size > aNumber
		ifTrue: [ n := aNumber ]
		ifFalse: [ n := self size ].
			
	^ self from: (self size - n + 1) to: (self size).
]

{ #category : #statistics }
DataSeries >> thirdQuartile [
	
	self signalErrorIfNotQuantitative.
	^ self quartile: 3
]

{ #category : #accessing }
DataSeries >> type [

	^ type.
]

{ #category : #'as yet unclassified' }
DataSeries >> unique [
	| unique |
	unique := self asSet asDataSeries.
	unique name: self name.
	^ unique
]

{ #category : #statistics }
DataSeries >> variance [

	self signalErrorIfNotQuantitative.
	^ super variance
]

{ #category : #enumerating }
DataSeries >> withIndexCollect: aBlock [

	| series |
	series := super withIndexCollect: aBlock.
	series name: self name.
	^ series
]

{ #category : #enumerating }
DataSeries >> withKeyDo: elementAndKeyBlock [

	1 to: self size do: [ :index |
		elementAndKeyBlock
			value: (contents at: index)
			value: (keys at: index) ].
]
