accessing
atKey: aKey ifAbsent: exceptionBlock
	
	| index |
	index := keys indexOf: aKey.
	
	index = 0
		ifTrue: [ ^ exceptionBlock value ].
		
	"In case contents and keys have different sizes"
	^ contents at: index ifAbsent: exceptionBlock.