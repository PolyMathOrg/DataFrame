accessing
indexOf: anElement startingAt: start ifAbsent: exceptionBlock
	"Answer the index of the first occurence of anElement after start
	within the receiver. If the receiver does not contain anElement, 
	answer the 	result of evaluating the argument, exceptionBlock."

	start to: self size do:
		[:index |
		(self at: (self keyAtIndex: index)) = anElement ifTrue: [^ index]].
	^ exceptionBlock value