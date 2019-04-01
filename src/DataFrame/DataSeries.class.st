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
	(aCollection species == self)
		ifTrue: [ ^ super newFrom: aCollection associations ].
		
	"If it's a collection of associations use the superclass implementation"
	^ super newFrom: ((aCollection first respondsTo: #key)
		ifTrue: [ aCollection ]
		ifFalse: [ aCollection withIndexCollect: [ :each :i | i -> each ] ]).
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

{ #category : #comparing }
DataSeries >> = anObject [
	(super = anObject)
		ifFalse: [ ^ false ].
		
	^ anObject name = self name
		"order of keys"
		and: [ anObject keys = self keys ]
]

{ #category : #adapting }
DataSeries >> adaptToCollection: rcvr andSend: selector [
	"If I am involved in arithmetic with another Collection, return a Collection of
	the results of each element combined with the scalar in that expression."

	(rcvr isSequenceable and: [ self isSequenceable ]) ifFalse:
		[self error: 'Only sequenceable collections may be combined arithmetically'].
	^ rcvr withSeries: self collect:
		[:rcvrElement :myElement | rcvrElement perform: selector with: myElement]
]

{ #category : #accessing }
DataSeries >> at: aKey transform: aBlock [
	"Evaluate aBlock on the value at aKey and replace that value with the result. Signal an exception if aKey was not found"
	self at: aKey transform: aBlock ifAbsent: NotFoundError.
]

{ #category : #accessing }
DataSeries >> at: aKey transform: aBlock ifAbsent: exceptionBlock [
	"Evaluate aBlock on the value at aKey and replace that value with the result. Evaluate exceptionBlock if aKey was not found"
	| oldValue |
	oldValue := self at: aKey ifAbsent: [
		exceptionBlock value.
		^ self ].
	
	self at: aKey put: (aBlock value: oldValue).
]

{ #category : #accessing }
DataSeries >> atIndex: aNumber [
	^ self at: (self keys at: aNumber)
]

{ #category : #accessing }
DataSeries >> atIndex: aNumber put: aValue [
	^ self at: (self keys at: aNumber) put: aValue
]

{ #category : #accessing }
DataSeries >> atIndex: aNumber transform: aBlock [
	"Evaluate aBlock on the value at aNumber and replace that value with the result"
	| key |
	key := self keys at: aNumber.
	self at: key transform: aBlock
]

{ #category : #comparing }
DataSeries >> closeTo: anObject [
	self == anObject
		ifTrue: [^ true].

	(self species == anObject species
		and: [self size = anObject size])
		ifFalse: [^ false].
		
	(anObject name = self name)
		ifFalse: [ ^ false ].
		
	(anObject keys = self keys)
		ifFalse: [ ^ false ].

	^ super closeTo: anObject
]

{ #category : #enumerating }
DataSeries >> collect: aBlock [
	| result |
	result :=  super collect: aBlock.
	result name: self name.
	^ result
]

{ #category : #statistics }
DataSeries >> crossTabulateWith: aSeries [
	| df |
	
	(self size = aSeries size)
		ifFalse: [ SizeMismatch signal ].
	
	df := DataFrame withRows: 
		(self uniqueValues collect: [ :each1 |
			aSeries uniqueValues collect: [ :each2 |
				(1 to: self size) inject: 0 into: [ :accum :i |
					(((self atIndex: i) = each1) and: ((aSeries atIndex: i) = each2))
						ifTrue: [ accum + 1 ]
						ifFalse: [ accum ] ] ] ]).
		
	df rowNames: self uniqueValues.
	df columnNames: aSeries uniqueValues.
	^ df
]

{ #category : #defaults }
DataSeries >> defaultHeadTailSize [
	^ 5
]

{ #category : #defaults }
DataSeries >> defaultName [
	^ '(no name)'
]

{ #category : #accessing }
DataSeries >> eighth [
	"Answer the eighth element of the receiver.
	Raise an error if there are not enough elements."
	^ self atIndex: 8
]

{ #category : #errors }
DataSeries >> errorKeysMismatch [
	Error signal: 'Keys of two series do not match'
]

{ #category : #accessing }
DataSeries >> fifth [
	"Answer the fifth element of the receiver.
	Raise an error if there are not enough elements."
	^ self atIndex: 5
]

{ #category : #accessing }
DataSeries >> first [ 
	"Answer the first element of the receiver.
	Raise an error if there are not enough elements."
	^ self atIndex: 1
]

{ #category : #statistics }
DataSeries >> firstQuartile [
	^ self quartile: 1
]

{ #category : #accessing }
DataSeries >> fourth [
	"Answer the fourth element of the receiver.
	Raise an error if there are not enough elements."
	^ self atIndex: 4
]

{ #category : #statistics }
DataSeries >> fourthQuartile [
	^ self quartile: 4
]

{ #category : #statistics }
DataSeries >> frequencyTable [
	| df count proportion |
	
	count := self valueCounts.
	proportion := count / self size.
	
	df := DataFrame withColumns:
		{ count asArray . proportion asArray }.
		
	df rowNames: self uniqueValues asArray.
	df columnNames: #(Count Proportion).
	
	^ df
]

{ #category : #grouping }
DataSeries >> groupBy: otherSeries aggregateUsing: aBlock [
	"Group my values by the unique values of otherSeries, aggregate them using aBlock. Use my name by default"
	^ self groupBy: otherSeries aggregateUsing: aBlock as: self name
]

{ #category : #grouping }
DataSeries >> groupBy: otherSeries aggregateUsing: aBlock as: aNewName [
	"Group my values by the unique values of otherSeries, aggregate them using aBlock, and answer a new DataSeries with unique values of otherSeries (group keys) as keys, aggregated values of myself as values, and aNewName as name"
	| groupKeys groups |
	
	self size = otherSeries size
		ifFalse: [ SizeMismatch signal ].
		
	groupKeys := otherSeries uniqueValues.
	
	groups := groupKeys collect: [ :each |
		(1 to: self size)
			select: [ :i | (otherSeries atIndex: i) = each ]
			thenCollect: [ :i | self atIndex: i ] ].
	
	^ DataSeries
		withKeys: groupKeys
		values: (groups collect: aBlock)
		name: aNewName
]

{ #category : #slicing }
DataSeries >> head [ 
	^ self head: self defaultHeadTailSize.
]

{ #category : #slicing }
DataSeries >> head: aNumber [
	^ self species
		withKeys: (self keys copyFrom: 1 to: aNumber)
		values: (self values copyFrom: 1 to: aNumber)
		name: self name.
]

{ #category : #initialization }
DataSeries >> initialize [ 
	super initialize.
	name := self defaultName.
]

{ #category : #initialization }
DataSeries >> initialize: aCapacity [
	"Make sure that initialize is called and the default name is set"
	self initialize.
	^ super initialize: aCapacity.
]

{ #category : #statistics }
DataSeries >> interquartileRange [
	^ self thirdQuartile - self firstQuartile 
]

{ #category : #testing }
DataSeries >> isSequenceable [
	^ true
]

{ #category : #accessing }
DataSeries >> keys: anArrayOfKeys [
	| keys |
	keys := anArrayOfKeys asArray deepCopy.
	dictionary := self dictionaryClass newFromKeys: keys andValues: self values.
	orderedKeys := keys.
]

{ #category : #accessing }
DataSeries >> last [
	"Answer the last element of the receiver.
	Raise an error if there are not enough elements."
	^ self atIndex: self size
]

{ #category : #accessing }
DataSeries >> mode [
	| valueCounts maxCount |
	valueCounts := self valueCounts.
	maxCount := valueCounts max.
	^ valueCounts keyAtValue: maxCount.
]

{ #category : #accessing }
DataSeries >> name [
	^ name
]

{ #category : #accessing }
DataSeries >> name: anObject [
	name := anObject
]

{ #category : #accessing }
DataSeries >> ninth [
	"Answer the ninth element of the receiver.
	Raise an error if there are not enough elements."
	^ self atIndex: 9
]

{ #category : #statistics }
DataSeries >> quantile: aNumber [
	| sortedSeries index |
	sortedSeries := self sort.
	
	aNumber = 0
		ifTrue: [ ^ sortedSeries first ].
	
	index := (sortedSeries size * (aNumber / 100)) ceiling.
	^ sortedSeries atIndex: index.
]

{ #category : #statistics }
DataSeries >> quartile: aNumber [
	^ self quantile: (25 * aNumber)
]

{ #category : #enumerating }
DataSeries >> reject: aBlock [
	| result |
	result := super reject: aBlock.
	result name: self name.
	^ result
]

{ #category : #removing }
DataSeries >> removeAt: aKey [
	^ self removeKey: aKey
]

{ #category : #removing }
DataSeries >> removeAtIndex: aNumber [
	^ self removeAt: (self keys at: aNumber)
]

{ #category : #accessing }
DataSeries >> second [
	"Answer the second element of the receiver.
	Raise an error if there are not enough elements."
	^ self atIndex: 2
]

{ #category : #statistics }
DataSeries >> secondQuartile [
	^ self quartile: 2
]

{ #category : #enumerating }
DataSeries >> select: aBlock [
	| result |
	result := super select: aBlock.
	result name: self name.
	^ result
]

{ #category : #accessing }
DataSeries >> seventh [
	"Answer the seventh element of the receiver.
	Raise an error if there are not enough elements."
	^ self atIndex: 7
]

{ #category : #accessing }
DataSeries >> sixth [
	"Answer the sixth element of the receiver.
	Raise an error if there are not enough elements."
	^ self atIndex: 6
]

{ #category : #sorting }
DataSeries >> sort [
	self sort: [ :a :b | a <= b ]
]

{ #category : #sorting }
DataSeries >> sort: aBlock [
	| associationBlock |
	associationBlock := [ :a :b | aBlock value: a value value: b value ].
	self sortAssociations: associationBlock
]

{ #category : #sorting }
DataSeries >> sortAssociations: aBlock [
	| sortedAssociations |
	sortedAssociations := self associations sort: aBlock.
	self removeAll.
	self addAll: sortedAssociations.
]

{ #category : #sorting }
DataSeries >> sortDescending [
	self sort: [ :a :b | a > b ]
]

{ #category : #sorting }
DataSeries >> sorted [
	^ self sorted: [ :a :b | a <= b ]
]

{ #category : #sorting }
DataSeries >> sorted: aBlock [
	| associationBlock |
	associationBlock := [ :a :b | aBlock value: a value value: b value ].
	^ self sortedAssociations: associationBlock
]

{ #category : #sorting }
DataSeries >> sortedAssociations: aBlock [
	| sortedAssociations |
	sortedAssociations := self associations sort: aBlock.
	^ sortedAssociations asDataSeries name: self name; yourself
]

{ #category : #sorting }
DataSeries >> sortedDescending [
	^ self sorted: [ :a :b | a > b ]
]

{ #category : #statistics }
DataSeries >> summary [
	| summary |
	summary := self species new.
	summary name: self name.
	
	summary
		at: 'Min' put: self min;
		at: '1st Qu.' put: self firstQuartile;
		at: 'Median' put: self median;
		at: 'Average' put: self average;
		at: '3rd Qu.' put: self thirdQuartile;
		at: 'Max' put: self max.
		
	^ summary
]

{ #category : #slicing }
DataSeries >> tail [
	^ self tail: self defaultHeadTailSize.
]

{ #category : #slicing }
DataSeries >> tail: aNumber [
	^ self species
		withKeys: (self keys copyFrom: self size - aNumber + 1 to: self size)
		values: (self values copyFrom: self size - aNumber + 1 to: self size)
		name: self name.
]

{ #category : #accessing }
DataSeries >> third [
	"Answer the third element of the receiver.
	Raise an error if there are not enough elements."
	^ self atIndex: 3
]

{ #category : #statistics }
DataSeries >> thirdQuartile [
	^ self quartile: 3
]

{ #category : #accessing }
DataSeries >> uniqueValues [
	| v |
	v := self asSet asArray.
	
	"Sort if possible"
	^ [ v sort ] on: Error do: [ v ].
]

{ #category : #statistics }
DataSeries >> valueCounts [
	^ (self groupBy: self aggregateUsing: #size) sortDescending
]

{ #category : #enumerating }
DataSeries >> with: aCollection collect: twoArgBlock [ 
	"Collect and return the result of evaluating twoArgBlock with corresponding elements from this series and aCollection."
	| result |
	aCollection size = self size ifFalse: [self errorSizeMismatch].
	
	result := self species new: self size.
	result name: self name.
	
	self keys withIndexDo: [ :key :i |
		result at: key put:
		(twoArgBlock
			value: (self at: key)
			value: (aCollection at: i))].
	^ result
]

{ #category : #enumerating }
DataSeries >> withIndexCollect: aBlock [
	| result |
	result := self species newFrom:
		(self associations withIndexCollect: [:each :i |
			each key -> (aBlock value: each value value: i)]).
	result name: self name.
	^ result
]

{ #category : #enumerating }
DataSeries >> withIndexDetect: aBlock [
	
	^ self withIndexDetect: aBlock ifNone: [ NotFound signal ].
]

{ #category : #enumerating }
DataSeries >> withIndexDetect: aBlock ifNone: exceptionBlock [
	
	| selectedIndex |
	
	selectedIndex := (1 to: self size)
		detect: [ :i | aBlock value: (self atIndex: i) value: i ]
		ifNone: [ ^ exceptionBlock value ].
		
	^ self atIndex: selectedIndex.
]

{ #category : #enumerating }
DataSeries >> withIndexDo: aBlock [
	self keys withIndexDo: [ :each :i | aBlock value: (self at: each) value: i ]
]

{ #category : #enumerating }
DataSeries >> withIndexReject: aBlock [
	^ self withIndexSelect: [ :each :i | (aBlock value: each value: i) not ]
]

{ #category : #enumerating }
DataSeries >> withIndexSelect: aBlock [
	| selectedIndices |
	
	selectedIndices := (1 to: self size) select: [ :i |
		aBlock value: (self atIndex: i) value: i ].
	
	^ DataSeries
		withKeys: (selectedIndices collect: [ :i | self keys at: i ])
		values: (selectedIndices collect: [ :i | self atIndex: i ])
		name: self name.
]

{ #category : #enumerating }
DataSeries >> withKeyCollect: aBlock [
	| result |
	result := self species newFrom:
		(self associations collect: [:each |
			each key -> (aBlock value: each value value: each key)]).
	result name: self name.
	^ result
]

{ #category : #enumerating }
DataSeries >> withKeyDetect: aBlock [
	
	^ self withKeyDetect: aBlock ifNone: [ NotFound signal ].
]

{ #category : #enumerating }
DataSeries >> withKeyDetect: aBlock ifNone: exceptionBlock [
	
	| selectedKey |
	
	selectedKey := self keys
		detect: [ :key | aBlock value: (self at: key) value: key ]
		ifNone: [ ^ exceptionBlock value ].
		
	^ self at: selectedKey.
]

{ #category : #enumerating }
DataSeries >> withKeyDo: aBlock [
	self keysDo: [ :each | aBlock value: (self at: each) value: each ]
]

{ #category : #enumerating }
DataSeries >> withKeyReject: aBlock [
	^ self withKeySelect: [ :each :key | (aBlock value: each value: key) not ]
]

{ #category : #enumerating }
DataSeries >> withKeySelect: aBlock [
	| selectedKeys |
	
	selectedKeys := self keys select: [ :key |
		aBlock value: (self at: key) value: key ].
	
	^ DataSeries
		withKeys: selectedKeys
		values: (selectedKeys collect: [ :key | self at: key ])
		name: self name.
]

{ #category : #enumerating }
DataSeries >> withSeries: otherDataSeries collect: twoArgBlock [ 
	"Collect and return the result of evaluating twoArgBlock with corresponding elements from this series and otherDataSeries."
	| result |
	otherDataSeries size = self size ifFalse: [self errorSizeMismatch].
	otherDataSeries keys = self keys ifFalse: [ self errorKeysMismatch ].
	
	result := self species new: self size.
	result name: self name.
	
	self keysDo: [ :key |
		result at: key put:
		(twoArgBlock
			value: (self at: key)
			value: (otherDataSeries at: key))].
	^ result
]

{ #category : #statistics }
DataSeries >> zerothQuartile [
	^ self quartile: 0
]
