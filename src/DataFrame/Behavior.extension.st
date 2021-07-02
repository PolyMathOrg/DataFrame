Extension { #name : #Behavior }

{ #category : #'*DataFrame-Core-Base' }
Behavior >> inheritsFromOrEqualTo: aClass [ 
	"Answer whether the argument, aClass, is equal to the receiver or belongs to its superclass chain."

	^ (self == aClass) or: (self inheritsFrom: aClass)
]
