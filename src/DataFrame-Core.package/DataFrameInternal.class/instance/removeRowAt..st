removing
removeRowAt: rowNumber

	| newContents |
	newContents := Matrix
		rows: (self numberOfRows - 1)
		columns: (self numberOfColumns).
		
	1 to: self numberOfColumns do: [ :j |
		1 to: rowNumber - 1 do: [ :i |
			newContents at: i at: j put:
				(contents at: i at: j) ].
			
		rowNumber + 1 to: self numberOfRows do: [ :i |
			newContents at: i - 1 at: j put:
				(contents at: i at: j) ] ].
		
	contents := newContents.