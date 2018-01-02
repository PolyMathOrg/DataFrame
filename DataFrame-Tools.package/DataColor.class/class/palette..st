examples
palette: n

	n <= (self defaultColors size)
		ifTrue: [ 
			^ (1 to: n) collect: [ :i |
				self fromHexString: (((self defaultColors) at: i) value) ] ]
		
		ifFalse: [ 
			^ self wheel: n saturation: 0.6 brightness: 0.8 ].