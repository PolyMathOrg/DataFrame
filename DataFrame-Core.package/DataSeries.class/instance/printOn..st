printing
printOn: aStream

	| df |
	df := DataFrame fromColumns: { self }.
	df columnNames: { self name }.
	df rowNames: self keys.
	df printOn: aStream.

	"aStream nextPutAll: 'a '.
	self class printOn: aStream.
	aStream cr.

	self name isNil
		ifFalse: [
			aStream
				nextPutAll: '''';
				nextPutAll: self name asString;
				nextPutAll: '''';
				cr ].
	
	self withKeyDo: [ :each :key |
		aStream nextPutAll: key asString.
		aStream tab.
		each printOn: aStream.
		
		key = keys last
			ifFalse: [ aStream cr ] ]."