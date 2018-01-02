private
apply: aBlock
	
	| colNames numberOfRows numberOfColumns result |
	
	colNames := (groups at: 1) columnNames.
	
	numberOfRows := groups size.
	numberOfColumns := colNames size.
	
	result := DataFrame new: (numberOfRows @ numberOfColumns).
	result rowNames: groups keys.
	result columnNames: colNames.
	
	groups doWithIndex: [ :df :i |
		1 to: colNames size do: [ :j |
			result at: i at: j put:
				(aBlock value: (df columnAt: j)) ] ].
		
	^ result