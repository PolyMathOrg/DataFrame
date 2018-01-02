reflective operations
doesNotUnderstand: aMessage

	^ self collect: [ :each |
		each
			perform: aMessage selector
			withArguments: aMessage arguments ]
	