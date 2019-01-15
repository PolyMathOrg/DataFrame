applying
toColumnAt: columnNumber applyElementwise: aBlock
		
	1 to: self numberOfRows do: [ :i |
		contents at: i at: columnNumber put:
			(aBlock value: (contents at: i at: columnNumber)) ].
		
	self induceColumnTypeAt: columnNumber.