Class {
	#name : #DataColor,
	#superclass : #Color,
	#category : 'DataFrame-Tools'
}

{ #category : #examples }
DataColor class >> blue [

	^ self fromHexString: (
		(self defaultColors detect: [ :assoc |
			assoc key = #blue ]) value).
]

{ #category : #examples }
DataColor class >> defaultColors [

	^ {'blue' -> '4C72B0' .
		'green' -> '55A868' .
		'red' -> 'C44E52' .
		'purple' -> '8172B2' .
		'yellow' -> 'CCB974' .
		'lightBlue' -> '64B5CD'}
]

{ #category : #examples }
DataColor class >> green [

	^ self fromHexString: (
		(self defaultColors detect: [ :assoc |
			assoc key = #green ]) value).
]

{ #category : #examples }
DataColor class >> lightBlue [

	^ self fromHexString: (
		(self defaultColors detect: [ :assoc |
			assoc key = #lightBlue ]) value).
]

{ #category : #examples }
DataColor class >> palette: n [

	n <= (self defaultColors size)
		ifTrue: [ 
			^ (1 to: n) collect: [ :i |
				self fromHexString: (((self defaultColors) at: i) value) ] ]
		
		ifFalse: [ 
			^ self wheel: n saturation: 0.6 brightness: 0.8 ].
]

{ #category : #examples }
DataColor class >> purple [

	^ self fromHexString: (
		(self defaultColors detect: [ :assoc |
			assoc key = #purple ]) value).
]

{ #category : #examples }
DataColor class >> red [

	^ self fromHexString: (
		(self defaultColors detect: [ :assoc |
			assoc key = #red ]) value).
]

{ #category : #examples }
DataColor class >> yellow [

	^ self fromHexString: (
		(self defaultColors detect: [ :assoc |
			assoc key = #yellow ]) value).
]
