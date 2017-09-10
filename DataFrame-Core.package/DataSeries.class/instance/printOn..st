printing
printOn: aStream

	| title |
	title := self class name.
	
	aStream
		nextPutAll: (title first isVowel ifTrue: ['an '] ifFalse: ['a ']);
		nextPutAll: title;
		nextPutAll: ' [';
		nextPutAll: self size asString;
		nextPutAll: (self size % 10 = 1 ifTrue: [' item]'] ifFalse: [' items]']);
		nextPutAll: ': ';
		nextPutAll: self type name.