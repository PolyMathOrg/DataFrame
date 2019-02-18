"
I induce the type of all the values inside DataSeries or DataFrame
"
Class {
	#name : #DataTypeInductor,
	#superclass : #Object,
	#category : #'DataFrame-Core'
}

{ #category : #'as yet unclassified' }
DataTypeInductor >> columnTypesOf: aDataFrame [
"Induces the column types of a data frame"

	| allClasses |
	
	^ (1 to: aDataFrame numberOfColumns) collect: [ :j |
		allClasses := Set new.
		
		1 to: aDataFrame numberOfRows do: [ :i | 
			allClasses add: (aDataFrame at: i at: j) class ].
		
		self leastCommonSuperclassOf: allClasses asArray. ].
]

{ #category : #private }
DataTypeInductor >> leastCommonSuperclassOf: anArray [
"Determines the closest element of class hierarchy which is the common ancestor of all the classes in the array"

	| commonSuperclass |
	
	anArray ifEmpty: [ 
		^ Object ].
	
	commonSuperclass := anArray first.
	
	2 to: anArray size do: [ :i |
		commonSuperclass := self
			leastCommonSuperclassOf: (anArray at: i)
			and: commonSuperclass. ].
	
	^ commonSuperclass.
]

{ #category : #private }
DataTypeInductor >> leastCommonSuperclassOf: firstClass and: secondClass [
"Determines the closest element of class hierarchy which is the common ancestor of two given classes"

	| classA classB |
	classA := firstClass.
	classB := secondClass.
	
	[ classA = Object or: (classB = Object) ]
		whileFalse: [ 
			(classA inheritsFromOrEqualTo: classB)
				ifTrue: [ ^ classB ].
				
			(classB inheritsFrom: classA)
				ifTrue: [ ^ classA ].
				
			classA := classA superclass.
			classB := classB superclass. ].
	
	^ Object.
]

{ #category : #'as yet unclassified' }
DataTypeInductor >> typeOf: aSeries [

	| allClasses |
	allClasses := Set new.
	
	aSeries do: [ :each |
		allClasses add: each class ].
	
	^ self leastCommonSuperclassOf: allClasses asArray.
]
