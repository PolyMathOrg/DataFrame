removing
removeColumnAt: columnNumber

	| newContents |
	newContents := Matrix
		rows: (self numberOfRows)
		columns: (self numberOfColumns - 1).
		
	1 to: self numberOfRows do: [ :i |
		1 to: columnNumber - 1 do: [ :j |
			newContents at: i at: j put:
				(contents at: i at: j) ].
			
		columnNumber + 1 to: self numberOfColumns do: [ :j |
			newContents at: i at: j - 1 put:
				(contents at: i at: j) ] ].
		
	contents := newContents.