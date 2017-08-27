gt-inspector-extension
gtInspectorPrettyPrintIn: composite
	<gtInspectorPresentationOrder: 10>
	<gtInspectorTag: #basic>
	
	composite text
		title: 'Pretty Print';
		display: [ 
			| stream |
			stream := String new writeStream.
			DataPrettyPrinter new print: self on: stream.
			stream contents ]