Extension { #name : #Array }

{ #category : #'*DataFrame' }
Array >> calculateDataType [

	(self
		 reject: #isNil
		 thenCollect: [ :each | each class ]) ifNotEmpty: [ :classes |
		| result |
		result := classes inject: classes first into: [ :commonSuperclass :each | self leastCommonSuperclassOf: commonSuperclass and: each ].
		"If we cannot detect the type, we configure it as Object."
		^ result isString
			  ifTrue: [ Object ]
			  ifFalse: [ result ] ].
	^ UndefinedObject
]

{ #category : #'*DataFrame' }
Array >> leastCommonSuperclassOf: firstClass and: secondClass [
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
