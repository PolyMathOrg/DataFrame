enumerating
withIndexCollect: aBlock

	| series |
	series := super withIndexCollect: aBlock.
	series name: self name.
	^ series