accessing
column: nameIndex

	columnNames detect: [ :name | name = nameIndex ]
		ifFound: [ | k |
			k := columnNames indexOf: nameIndex.
			^ self columnAt: k ]
		ifNone: [ 
			NotFoundError signal ].