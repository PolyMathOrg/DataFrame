instance creation
fromColumns: anArrayOfArrays
	
	| numberOfRows numberOfColumns dfInternal |
	
	numberOfRows := anArrayOfArrays first size.
	numberOfColumns := anArrayOfArrays size.
	dfInternal := self new: (numberOfRows @ numberOfColumns ).
	
	1 to: numberOfRows do: [ :i |
		1 to: numberOfColumns do: [ :j |
			dfInternal at: i at: j put:
				((anArrayOfArrays at: j) at: i) ] ].
		
	^ dfInternal