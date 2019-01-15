enumerating
withKeyDo: elementAndKeyBlock

	1 to: self size do: [ :index |
		elementAndKeyBlock
			value: (self rowAt: index)
			value: (rowNames at: index) ].