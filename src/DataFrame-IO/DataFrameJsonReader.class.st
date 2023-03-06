Class {
	#name : #DataFrameJsonReader,
	#superclass : #DataFrameReader,
	#instVars : [
		'rowNames',
		'rows',
		'columnNames',
		'orient',
		'uniform',
		'parseMap'
	],
	#category : #'DataFrame-IO'
}

{ #category : #adding }
DataFrameJsonReader >> addDict: aDict [
	"Adds aDict while respecting columnNames positions"

	| newCols |

	newCols := aDict keys difference: columnNames.
	columnNames addAll: newCols.

	rows add: (columnNames collect: [ :col | aDict at: col ifAbsent: nil ])
]

{ #category : #reading }
DataFrameJsonReader >> createDataFrame [
	| df |

	df := DataFrame withRows: rows.
	rowNames ifNotNil: [ df rowNames: rowNames ].
	columnNames ifNotNil: [ df columnNames: columnNames  ].

	DataFrameTypeDetector new detectTypesAndConvert: df.

	^ df
]

{ #category : #'initialization - private' }
DataFrameJsonReader >> inferOrientFromJson: json [
	"Inferes the json type (orient parameter). Runs when orient='auto'"

	(json isKindOf: SequenceableCollection)
		ifTrue: [
			((json first) isKindOf: SequenceableCollection)
				ifTrue: [ self orient: 'values' ]
				ifFalse: [ self orient: 'records' ]
			]
		ifFalse: [
			((json at: (json keys first)) isKindOf: SequenceableCollection)
				ifTrue: [ self orient: 'split' ]
				ifFalse: [ self orient: 'columns' ].
			]
]

{ #category : #initialization }
DataFrameJsonReader >> initialize [
	super initialize.
	orient := self orientDefaultValue.
	uniform := self uniformDefaultValue.
	parseMap := Dictionary newFrom: {
		'records'->[ :json | self parseFromRecords: json ].
		'columns'->[ :json | self parseFromColumns: json ].
		'index'->[ :json | self parseFromRowNames: json ].
		'values'->[ :json | self parseFromValues: json ].
		'split'->[ :json | self parseFromSplit: json ].
		}
]

{ #category : #accessing }
DataFrameJsonReader >> orient [
	^ orient
]

{ #category : #accessing }
DataFrameJsonReader >> orient: aString [
	orient := aString
]

{ #category : #accessing }
DataFrameJsonReader >> orientDefaultValue [
	^ 'auto'
]

{ #category : #parsing }
DataFrameJsonReader >> parseFromColumns: aDict [
	"Private. Accessed when orient = 'columns'.
	 Slower if uniform is set to false.
	 Incoming json format is:

		{
		 column->{
					 rowName->data
					}
		}

	"
	| colIndex rowIndex |

	columnNames := OrderedCollection newFrom: aDict keys.
	rowNames := OrderedCollection new.
	rows := OrderedCollection new.

	aDict keysAndValuesDo: [ :col :rowNamesDict |
		colIndex := columnNames indexOf: col.
		rowNamesDict keysAndValuesDo: [ :rowName :val |
			rowIndex := rowNames indexOf: rowName ifAbsent: [
				rowNames add: rowName. rowNames size ].
			"Basically `row at:rowIndex at:colIndex put:val`"
			(rows at: rowIndex
					ifAbsentPut: (OrderedCollection ofSize: columnNames size)
					)	at: colIndex
						ifAbsentPut: val.
			].
		]
]

{ #category : #parsing }
DataFrameJsonReader >> parseFromRecords: anArray [
	"Private. Accessed when orient = 'records'.
	 Incoming json format is:
		[
			{column->data},
		]
	"

	rows := OrderedCollection new: anArray size.
	columnNames := OrderedCollection new.
	rowNames := nil.

	anArray do: [ :record |
		self addDict: record
		]
]

{ #category : #parsing }
DataFrameJsonReader >> parseFromRowNames: aDict [
	"Private. Accessed when orient = 'rowNames'.
	 Slower if uniform is set to false.
	 Incoming json format is:
		{
		 rowName->{
					 column->data
					}
		}
	"

	columnNames := OrderedCollection new.
	rowNames := OrderedCollection new: (aDict keys) size.
	rows := OrderedCollection new: (aDict keys) size.

	aDict keysAndValuesDo: [ :rowName :rowNamesDict |
		rowNames add: rowName.
		self addDict: rowNamesDict.
		]
]

{ #category : #parsing }
DataFrameJsonReader >> parseFromSplit: aDict [
	"Private. Accessed when orient = 'split'.
	 Incoming json format is:
		{
			index->[rowNames],
			columns->[columnNames],
			data->[data]
		}
	"

	rows := aDict at: 'data'.
	rowNames := aDict at: 'index'.
	columnNames := aDict at: 'columns'
]

{ #category : #parsing }
DataFrameJsonReader >> parseFromValues: anArrayOfArrays [
	"Private. Accessed when orient = 'values'"

	rows := anArrayOfArrays
]

{ #category : #reading }
DataFrameJsonReader >> read: json [
	"Loads parsed json"

	json ifEmpty: [ rows := #(  ) ] ifNotEmpty: [
		orient = 'auto' ifTrue: [ self inferOrientFromJson: json ].
		(parseMap at: orient) value: json ]
]

{ #category : #reading }
DataFrameJsonReader >> readFrom: aFileReference [
	| reader |

	reader := NeoJSONReader on: aFileReference readStream.
	self read: reader next.
	reader close.

	^ self createDataFrame
]

{ #category : #reading }
DataFrameJsonReader >> readFromString: aString [
	"Read dataframe from a string"
	| json |

	json := NeoJSONReader fromString: aString.
	self read: json.

	^ self createDataFrame
]

{ #category : #accessing }
DataFrameJsonReader >> uniform [
	^ uniform
]

{ #category : #accessing }
DataFrameJsonReader >> uniform: aBoolean [
	uniform := aBoolean
]

{ #category : #accessing }
DataFrameJsonReader >> uniformDefaultValue [
	^ false
]
