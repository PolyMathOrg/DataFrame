accessing
column: nameIndex

	columnNames detect: [ :name | name = nameIndex ]
		ifFound: [ 
			| series |
			series := (self values collect: [ :row |
				row at: nameIndex ]) asDataSeries.
			^ series name: nameIndex ]
		ifNone: [ 
			NotFoundError signal ].