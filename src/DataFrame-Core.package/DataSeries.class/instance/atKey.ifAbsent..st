accessing
atKey: aKey ifAbsent: exceptionBlock
	
	| index |
	index := self indexOfKey: aKey ifAbsent: exceptionBlock.
		
	"In case contents and keys have different sizes"
	^ contents at: index ifAbsent: exceptionBlock.