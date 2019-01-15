instance creation
fromRows: anArrayOfArrays

	| numberOfRows numberOfColumns dfInternal |
	
	numberOfRows := anArrayOfArrays size.
	numberOfColumns := anArrayOfArrays first size.
	dfInternal := self new: (numberOfRows @ numberOfColumns ).
	
	1 to: numberOfRows do: [ :i |
		1 to: numberOfColumns do: [ :j |
			dfInternal at: i at: j put:
				((anArrayOfArrays at: i) at: j) ] ].
		
	^ dfInternal