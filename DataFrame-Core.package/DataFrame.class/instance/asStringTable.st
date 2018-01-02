printing
asStringTable

	| stream |
	stream := String new writeStream.
	DataPrettyPrinter new print: self on: stream.
	^ stream contents