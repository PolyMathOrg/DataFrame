private
leastCommonSuperclassOf: firstClass and: secondClass
"Determines the closest element of class hierarchy which is the common ancestor of two given classes"

	| classA classB |
	classA := firstClass.
	classB := secondClass.
	
	[ classA = Object or: (classB = Object) ]
		whileFalse: [ 
			((classA inheritsFrom: classB) or:
			(classA == classB)) 
				ifTrue: [ ^ classB ].
				
			(classB inheritsFrom: classA)
				ifTrue: [ ^ classA ].
				
			classA := classA superclass.
			classB := classB superclass. ].
	
	^ Object.