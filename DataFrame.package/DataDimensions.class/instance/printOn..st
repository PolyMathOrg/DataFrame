accessing vectorwise
printOn: aStream

	aStream
		nextPutAll: x asString, ' rows'; cr;
		nextPutAll: y asString, ' columns'.
		