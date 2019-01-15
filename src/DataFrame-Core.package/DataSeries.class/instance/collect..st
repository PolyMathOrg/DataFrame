enumerating
collect: aBlock

	| series |
	series := super collect: aBlock.
	series name: self name.
	series keys: self keys.
	^ series