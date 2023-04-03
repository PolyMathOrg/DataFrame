Class {
	#name : #DataSeries,
	#superclass : #OrderedDictionary,
	#instVars : [
		'name',
		'forcedIsNumerical'
	],
	#category : #'DataFrame-Core'
}

{ #category : #'instance creation' }
DataSeries class >> newFrom: aCollection [

	aCollection ifEmpty: [ ^ self new ].

	aCollection species == self ifTrue: [ ^ super newFrom: aCollection associations ].

	"If it's a collection of associations use the superclass implementation"
	^ super newFrom: (aCollection anyOne isAssociation
			   ifTrue: [ aCollection ]
			   ifFalse: [ aCollection withIndexCollect: [ :each :i | i -> each ] ])
]

{ #category : #'instance creation' }
DataSeries class >> newFromKeys: keys andValues: values [

	| dict |
	self flag: #pharo12. "This is a copy of the superclass with a speed up. I'll propose this speedup in Pharo 12 so when Pharo 12 will be the minimal suuported version then we can drop this method."
	dict := self new: keys size.
	keys with: values do: [ :k :v | dict at: k put: v ].
	^ dict
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
DataSeries >> < arg [
	"Element-wise comparision between two DataSeries.
	 Does not consider keys for comparision."

	^ arg adaptToCollection: self andSend: #<
]

{ #category : #comparing }
DataSeries >> <= arg [
	"Element-wise comparision between two DataSeries.
	 Does not consider keys for comparision."

	^ arg adaptToCollection: self andSend: #<=
]

{ #category : #comparing }
DataSeries >> = anObject [
	(super = anObject)
		ifFalse: [ ^ false ].

	^ anObject name = self name
		"order of keys"
		and: [ anObject keys = self keys ]
]

{ #category : #comparing }
DataSeries >> > arg [
	"Element-wise comparision between two DataSeries.
	 Does not consider keys for comparision."

	^ arg adaptToCollection: self andSend: #>
]

{ #category : #comparing }
DataSeries >> >= arg [
	"Element-wise comparision between two DataSeries.
	 Does not consider keys for comparision."

	^ arg adaptToCollection: self andSend: #>=
]

{ #category : #adapting }
DataSeries >> adaptToCollection: rcvr andSend: selector [
	"If I am involved in arithmetic with another Collection, return a Collection of
	the results of each element combined with the scalar in that expression."

	(rcvr isSequenceable and: [ self isSequenceable ]) ifFalse: [ self error: 'Only sequenceable collections may be combined arithmetically' ].


	^ rcvr withSeries: self collect: [ :rcvrElement :myElement |
		  (rcvrElement isNil or: [ myElement isNil ])
			  ifTrue: [ nil ]
			  ifFalse: [ rcvrElement perform: selector with: myElement ] ]
]

{ #category : #converting }
DataSeries >> asDataFrame [
	"Converts a data series to a data frame with 1 column. The values in the column of the data frame are the values of the data series. The row names of this data frame are the keys of the data series. The column name of the data frame is same as the name of the data series"
	
	^ DataFrame
		withColumns: {  self values }
		rowNames: self keys
		columnNames: { self name }
]

{ #category : #accessing }
DataSeries >> at: aKey transform: aBlock [
	"Evaluate aBlock on the value at aKey and replace that value with the result. Signal an exception if aKey was not found"
	self at: aKey transform: aBlock ifAbsent: [ self errorKeyNotFound: aKey ]
]

{ #category : #accessing }
DataSeries >> at: aKey transform: aBlock ifAbsent: exceptionBlock [
	"Evaluate aBlock on the value at aKey and replace that value with the result. Evaluate exceptionBlock if aKey was not found"
	| oldValue |
	oldValue := self at: aKey ifAbsent: [
		exceptionBlock value.
		^ self ].

	self at: aKey put: (aBlock value: oldValue)
]

{ #category : #accessing }
DataSeries >> atAll: aCollectionOfIndexes [
	"Returns a data series of only those elements of the receiver whose indices are present in the collection aCollectionOfIndexes"
	
	^ self withIndexSelect: [ :each :index | aCollectionOfIndexes includes: index ]
]

{ #category : #accessing }
DataSeries >> atIndex: aNumber [
	"Answer the element of the receiver at index aNumber"
	
	^ self at: (self keys at: aNumber)
]

{ #category : #accessing }
DataSeries >> atIndex: aNumber put: aValue [
	"Replace the element of the receiver at index aNumber with the value aValue"

	^ self at: (self keys at: aNumber) put: aValue
]

{ #category : #accessing }
DataSeries >> atIndex: aNumber transform: aBlock [
	"Evaluate aBlock on the value at aNumber and replace that value with the result"
	| key |
	key := self keys at: aNumber.
	self at: key transform: aBlock
]

{ #category : #information }
DataSeries >> average [
	"We do not count the nils"

	^ (self values reject: #isNil) average
]

{ #category : #'data-types' }
DataSeries >> calculateDataType [
	"Returns the data type of the data series"
	
	^ self values calculateDataType
]

{ #category : #comparing }
DataSeries >> closeTo: anObject [
	^ self closeTo: anObject precision: self defaultPrecision
]

{ #category : #comparing }
DataSeries >> closeTo: anObject precision: aPrecision [
	self == anObject
		ifTrue: [^ true].

	(self species == anObject species
		and: [self size = anObject size])
		ifFalse: [^ false].

	(anObject name = self name)
		ifFalse: [ ^ false ].

	(anObject keys = self keys)
		ifFalse: [ ^ false ].

	^ (1 to: self values size)
		detect: [ :i | ((self atIndex: i) closeTo: (anObject atIndex: i) precision: aPrecision) not ]
		ifFound: [ false ]
		ifNone: [ true ]
]

{ #category : #enumerating }
DataSeries >> collect: aBlock [
	"Applies aBlock to every element"

	| result |
	result :=  super collect: aBlock.
	result name: self name.
	^ result
]

{ #category : #enumerating }
DataSeries >> collectWithNotNils: aBlock [
	"Applies aBlock to every non-nil element"

	^ self collect: [ :each | each ifNotNil: [ aBlock value: each ] ]
]

{ #category : #'math functions' }
DataSeries >> correlationWith: otherSeries [
	"Calculate the Pearson correlation coefficient between self and the other series"
	^ self correlationWith: otherSeries using: DataPearsonCorrelationMethod
]

{ #category : #'math functions' }
DataSeries >> correlationWith: otherSeries using: aCorrelationCoefficient [
	"Calculate the correlation coefficient between self and the other series using the given method"
	^ aCorrelationCoefficient between: self and: otherSeries
]

{ #category : #statistics }
DataSeries >> crossTabulateWith: aSeries [
	"A DataFrame is returned which is useful in quantitatively analyzing the relationship of values in one data series with the values in another data series"
	
	| df |

	(self size = aSeries size)
		ifFalse: [ SizeMismatch signal ].

	df := DataFrame withRows:
		(self uniqueValues sortIfPossible collect: [ :each1 |
			aSeries uniqueValues sortIfPossible collect: [ :each2 |
				(1 to: self size) inject: 0 into: [ :accum :i |
					(((self atIndex: i) = each1) and: ((aSeries atIndex: i) = each2))
						ifTrue: [ accum + 1 ]
						ifFalse: [ accum ] ] ] ]).

	df rowNames: self uniqueValues sortIfPossible.
	df columnNames: aSeries uniqueValues sortIfPossible.
	^ df
]

{ #category : #statistics }
DataSeries >> cumulativeSum [
	"Calculate the cumulative sum of a data series and return a new data series with keys as self keys and values as cumulative sum"

	| sum |
	sum := 0.

	^ self collect: [ :each |
		each ifNotNil: [ sum := sum + each ].
		sum ]
]

{ #category : #defaults }
DataSeries >> defaultHeadTailSize [
	^ 5
]

{ #category : #defaults }
DataSeries >> defaultName [
	^ '(no name)'
]

{ #category : #defaults }
DataSeries >> defaultPrecision [
	^ 0.0001
]

{ #category : #accessing }
DataSeries >> eighth [
	"Answer the eighth element of the receiver.
	Raise an error if there are not enough elements."
	^ self atIndex: 8
]

{ #category : #private }
DataSeries >> errorKeyNotFound: aKey [

	KeyNotFound signalFor: aKey
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
    "25% of the values in a set are smaller than or equal to the first Quartile of that set"

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
    "Fourth Quartile is the maximum value in a set of values"

	^ self quartile: 4
]

{ #category : #grouping }
DataSeries >> groupBy: otherSeries aggregateUsing: aBlock [
	"Group my values by the unique values of otherSeries, aggregate them using aBlock. Use my name by default"
	^ self groupBy: otherSeries aggregateUsing: aBlock as: self name
]

{ #category : #grouping }
DataSeries >> groupBy: otherSeries aggregateUsing: aBlock as: aNewName [
	"Group my values by the unique values of otherSeries, aggregate them using aBlock, and answer a new DataSeries with unique values of otherSeries as keys, aggregated values of myself as values, and aNewName as name"

	| groupMap |
	self size = otherSeries size ifFalse: [ SizeMismatch signal ].

	groupMap := (otherSeries uniqueValues sortIfPossible collect: [ :e | e -> OrderedCollection new ]) asOrderedDictionary.

	1 to: self size do: [ :index | (groupMap at: (otherSeries atIndex: index)) add: (self atIndex: index) ].

	^ self class withKeys: groupMap keys values: (groupMap values collect: aBlock) name: aNewName
]

{ #category : #grouping }
DataSeries >> groupByBins: bins [

	^ self groupByBins: bins labelled: (1 to: bins size - 1)
]

{ #category : #grouping }
DataSeries >> groupByBins: bins labelled: aCollection [
	"I receive two parameters:
	- A collection of bins that will determine intervals to group the values
	- A collection of labels to apply for each intervals of the bins

	I return a new DataSeries associating each key to a label corresponding to the bin they match."

	| labelledIntervals |
	bins size = (aCollection size + 1) ifFalse: [ SizeMismatch signal: 'The labels should have one less elements than the bins.' ].

	labelledIntervals := OrderedDictionary new.
	bins overlappingPairsWithIndexDo: [ :min :max :index | labelledIntervals at: (aCollection at: index) put: min -> max ].

	^ self collect: [ :each | labelledIntervals keyAtValue: (labelledIntervals values detect: [ :asso | each between: asso key and: asso value ]) ]
]

{ #category : #grouping }
DataSeries >> groupByUniqueValuesAndAggregateUsing: aBlock [
	"Group my values by their unique values and aggregate them using aBlock. Use my name by default"
	^ self groupByUniqueValuesAndAggregateUsing: aBlock as: self name
]

{ #category : #grouping }
DataSeries >> groupByUniqueValuesAndAggregateUsing: aBlock as: aNewName [
	"Group my values by unique values, aggregate them using aBlock, and answer a new DataSeries with theunique values as keys, aggregated values of myself as values, and aNewName as name"

	| groupMap |
	groupMap := (self uniqueValues sortIfPossible collect: [ :e | e -> OrderedCollection new ]) asOrderedDictionary.

	self do: [ :each | (groupMap at: each) add: each ].

	^ self class withKeys: groupMap keys values: (groupMap values collect: aBlock) name: aNewName
]

{ #category : #testing }
DataSeries >> hasNil [
	"return true if data series has at least one nil value"
	^ self includes: nil.
]

{ #category : #slicing }
DataSeries >> head [
	"Returns a data series with first 5 elements of the receiver"
	
	^ self head: self defaultHeadTailSize
]

{ #category : #slicing }
DataSeries >> head: aNumber [
	"Returns a data series with first aNumber elements of the receiver"

	^ self species
		withKeys: (self keys copyFrom: 1 to: aNumber)
		values: (self values copyFrom: 1 to: aNumber)
		name: self name
]

{ #category : #initialization }
DataSeries >> initialize [
	super initialize.
	name := self defaultName
]

{ #category : #initialization }
DataSeries >> initialize: aCapacity [
	"Make sure that initialize is called and the default name is set"
	self initialize.
	^ super initialize: aCapacity
]

{ #category : #statistics }
DataSeries >> interquartileRange [
	"The Inter Quartile Range is the difference between the third Quartile and the first Quartile"

	^ self thirdQuartile - self firstQuartile
]

{ #category : #'categorical-numerical' }
DataSeries >> isCategorical [
	"Returns true if atleast one value of the data series is non numerical and returns false otherwise"

	^ self isNumerical not
]

{ #category : #'categorical-numerical' }
DataSeries >> isNumerical [
	"Returns true if all values of the data series are numerical values and returns false otherwise"
	
	^ forcedIsNumerical ifNil: [ (self uniqueValues copyWithout: nil) allSatisfy: [ :each | each isNumber ] ]
]

{ #category : #testing }
DataSeries >> isSequenceable [
	^ true
]

{ #category : #private }
DataSeries >> keys: anArrayOfKeys [
	| keys |
	keys := anArrayOfKeys asArray deepCopy.
	dictionary := self dictionaryClass newFromKeys: keys andValues: self values.
	orderedKeys := keys
]

{ #category : #accessing }
DataSeries >> last [
	"Answer the last element of the receiver.
	Raise an error if there are not enough elements."
	^ self atIndex: self size
]

{ #category : #'math functions' }
DataSeries >> log: base [
	^ self collect: [ :each | each log: base ]
]

{ #category : #'categorical-numerical' }
DataSeries >> makeCategorical [
	"Converts a data series to a categorical data series"
	
	forcedIsNumerical := false
]

{ #category : #'categorical-numerical' }
DataSeries >> makeNumerical [
	"Converts a data series to a numerical data series"

	forcedIsNumerical := true
]

{ #category : #accessing }
DataSeries >> mode [
	"The mode of a set of values is the value that appears most often. "

	| valueCounts |
	valueCounts := self valueCounts.
	^ valueCounts keyAtValue: valueCounts max
]

{ #category : #accessing }
DataSeries >> name [
	"Answer the name of the receiver"
	
	^ name
]

{ #category : #accessing }
DataSeries >> name: anObject [
	"Set the name of the receiver to anObject"
	
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
	"A quantile determines how many values in a distribution are above or below a certain limit.
Eg: if the parameter aNumber is 85, a value from the data series is returned which is greater than or equal to 85% of the values in the data series"

	| sortedSeries index |
	sortedSeries := self withoutNils sorted.

	aNumber = 0 ifTrue: [ ^ sortedSeries first ].

	index := (sortedSeries size * (aNumber / 100)) ceiling.
	^ sortedSeries atIndex: index
]

{ #category : #statistics }
DataSeries >> quartile: aNumber [
	"Quartiles are three values that split sorted data into four parts, each with an equal number of observations.
Eg: if the parameter aNumber is 3, the Third Quartile of the data series is returned"
	
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
	"Removes element from the data series with key aKey"
	
	^ self removeKey: aKey
]

{ #category : #removing }
DataSeries >> removeAtIndex: aNumber [
	"Removes element from the data series with index aNumber"

	^ self removeAt: (self keys at: aNumber)
]

{ #category : #removing }
DataSeries >> removeNils [
	"Removes elements with nil values from the data series"
	
	^ self reject: [ :ele | ele isNil ]
]

{ #category : #replacing }
DataSeries >> replaceNilsWith: anObject [
	"Replaces nils inplace with anObject"

	self withIndexDo: [ :ele :index | ele ifNil: [ self atIndex: index put: anObject ] ]
]

{ #category : #replacing }
DataSeries >> replaceNilsWithAverage [
	"Replaces nils inplace with average"

	| mean |
	mean := (self select: [ :ele | ele isNotNil ]) average.
	self replaceNilsWith: mean
]

{ #category : #replacing }
DataSeries >> replaceNilsWithMedian [
	"Replaces nils inplace with median"

	| median |
	median := (self select: [ :ele | ele isNotNil ]) median.
	self replaceNilsWith: median
]

{ #category : #replacing }
DataSeries >> replaceNilsWithMode [
	"Replaces nils inplace with mode"

	| mode |
	mode := (self select: [ :ele | ele isNotNil ]) mode.
	self replaceNilsWith: mode
]

{ #category : #replacing }
DataSeries >> replaceNilsWithPreviousValue [

	"Replaces nils inplace with previous non-nil value"

	| value |
	self withIndexDo: [ :ele :index |
		index > 1 ifTrue: [ ele ifNil: [ self atIndex: index put: value ] ].
		value := self atIndex: index ]
]

{ #category : #replacing }
DataSeries >> replaceNilsWithZeros [
	"Replaces nils inplace with zero"

	self replaceNilsWith: 0
]

{ #category : #accessing }
DataSeries >> second [
	"Answer the second element of the receiver.
	Raise an error if there are not enough elements."
	^ self atIndex: 2
]

{ #category : #statistics }
DataSeries >> secondQuartile [
    "50% of the values in a set are smaller than or equal to the second Quartile of that set. It is also known as the median"

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
	"Arranges a data series in ascending order of its values"
	
	self sort: [ :a :b | a <= b ]
]

{ #category : #sorting }
DataSeries >> sort: aBlock [
	"Arranges a data series by applying aBlock on its values"

	| associationBlock |
	associationBlock := [ :a :b | aBlock value: a value value: b value ].
	self sortAssociations: associationBlock
]

{ #category : #sorting }
DataSeries >> sortAssociations: aBlock [
	| sortedAssociations |
	sortedAssociations := self associations sort: aBlock.
	self removeAll.
	self addAll: sortedAssociations
]

{ #category : #sorting }
DataSeries >> sortDescending [
	"Arranges a data series in descending order of its values"

	self sort: [ :a :b | a > b ]
]

{ #category : #sorting }
DataSeries >> sorted [
	"Returns a sorted copy of the data series without rearranging the original data series"
	
	^ self sorted: [ :a :b | a <= b ]
]

{ #category : #sorting }
DataSeries >> sorted: aBlock [
	"Returns a copy of the data series after applying aBlock without rearranging the original data series"

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
	"Returns a sorted copy of the data series in descending order without rearranging the original data series"

	^ self sorted: [ :a :b | a > b ]
]

{ #category : #transformation }
DataSeries >> sum [
	"Return the sum of the values over the requested axis. Nil values are excluded."

	| result |
	result := 0.
	self do: [ :each | each ifNotNil: [ result := result + each ] ].
	^ result
]

{ #category : #statistics }
DataSeries >> summary [
	"A data series is returned which is a statistical summary of the data series. With keys as different statistical measures and values as the values returned when those statistical measures are applied on the data series."
	
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
	"Returns a data series with last 5 elements of the receiver"

	^ self tail: self defaultHeadTailSize
]

{ #category : #slicing }
DataSeries >> tail: aNumber [
	"Returns a data series with last aNumber elements of the receiver"

	^ self species
		withKeys: (self keys copyFrom: self size - aNumber + 1 to: self size)
		values: (self values copyFrom: self size - aNumber + 1 to: self size)
		name: self name
]

{ #category : #accessing }
DataSeries >> third [
	"Answer the third element of the receiver.
	Raise an error if there are not enough elements."
	^ self atIndex: 3
]

{ #category : #statistics }
DataSeries >> thirdQuartile [
   "75% of the values in a set are smaller than or equal to the third Quartile of that set"

	^ self quartile: 3
]

{ #category : #accessing }
DataSeries >> uniqueValues [
	"Answer the unique values of the receiver"
	
	^ self asSet asArray
]

{ #category : #statistics }
DataSeries >> valueCounts [
	"Calculates the frequency of each value in the data series and returns a data series in descending order of frequencies"
	
	^ (self groupByUniqueValuesAndAggregateUsing: #size) sortDescending
]

{ #category : #statistics }
DataSeries >> valueFrequencies [
	"Calculates the relative frequency of values in the data series. Relative frequency is the ratio of the number of times a value occurs in a set to the total number of values in the set"
	
	| count freq |
	count := self valueCounts.
	freq := count / self size.
	^ freq
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

	^ self withIndexDetect: aBlock ifNone: [ NotFound signal ]
]

{ #category : #enumerating }
DataSeries >> withIndexDetect: aBlock ifNone: exceptionBlock [

	| selectedIndex |

	selectedIndex := (1 to: self size)
		detect: [ :i | aBlock value: (self atIndex: i) value: i ]
		ifNone: [ ^ exceptionBlock value ].

	^ self atIndex: selectedIndex
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
		name: self name
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

	^ self withKeyDetect: aBlock ifNone: [ NotFound signal ]
]

{ #category : #enumerating }
DataSeries >> withKeyDetect: aBlock ifNone: exceptionBlock [

	| selectedKey |

	selectedKey := self keys
		detect: [ :key | aBlock value: (self at: key) value: key ]
		ifNone: [ ^ exceptionBlock value ].

	^ self at: selectedKey
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
		name: self name
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

{ #category : #private }
DataSeries >> withoutNils [
	"Returns a data series without the elements whose values were nil values"
	
	^ self reject: #isNil
]

{ #category : #statistics }
DataSeries >> zerothQuartile [
    "Zeroth Quartile is the minimum value in a set of values"

	^ self quartile: 0
]
