*DFTools-Inspector
gtInspectorScatterplotMatrixIn: composite
	<gtInspectorPresentationOrder: 2>
	<gtInspectorTag: #basic>
	
	composite roassal2
		title: 'Scatterplot Matrix';
		initializeView: [ self scatterplotMatrix ];
		when: [ false "When fixed" ]