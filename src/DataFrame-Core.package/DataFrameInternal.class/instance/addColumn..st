adding
addColumn: anArray

	| newContents |
	
	anArray size = self numberOfRows
		ifFalse: [ SizeMismatch signal ].
	
	newContents := Matrix
		rows: (self numberOfRows)
		columns: (self numberOfColumns + 1).
	
	1 to: self numberOfRows do: [ :i |
		1 to: self numberOfColumns do: [ :j |
			newContents at: i at: j put:
				(self at: i at: j) ] ].
	
	1 to: self numberOfRows do: [ :i |
		newContents at: i at: (self numberOfColumns + 1)
			put: (anArray at: i) ].
	
	contents := newContents.