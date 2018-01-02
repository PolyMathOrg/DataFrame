enumerating
withKeyDo: elementAndKeyBlock

	1 to: self size do: [ :index |
		elementAndKeyBlock
			value: (contents at: index)
			value: (keys at: index) ].