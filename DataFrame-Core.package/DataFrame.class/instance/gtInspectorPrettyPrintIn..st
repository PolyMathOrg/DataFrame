as yet unclassified
gtInspectorPrettyPrintIn: composite
	<gtInspectorPresentationOrder: 1>
	<gtInspectorTag: #basic>
	
	composite text
		title: 'PrettyPrint';
		display: [ 
			| stream |
			stream := String new writeStream.
			DataPrettyPrinter new print: self on: stream.
			stream contents ]