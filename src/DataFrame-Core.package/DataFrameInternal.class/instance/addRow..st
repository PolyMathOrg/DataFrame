adding
addRow: anArray

	| newContents |
	
	anArray size = self numberOfColumns
		ifFalse: [ SizeMismatch signal ].
	
	newContents := Matrix
		rows: (self numberOfRows + 1)
		columns: (self numberOfColumns).
	
	1 to: self numberOfRows do: [ :i |
		1 to: self numberOfColumns do: [ :j |
			newContents at: i at: j put:
				(self at: i at: j) ] ].
	
	1 to: self numberOfColumns do: [ :j |
		newContents at: (self numberOfRows + 1) at: j
			put: (anArray at: j) ].
	
	contents := newContents.