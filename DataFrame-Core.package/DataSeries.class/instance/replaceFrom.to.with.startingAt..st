accessing
replaceFrom: start to: stop with: replacement startingAt: repStart 

	(replacement isKindOf: self class)
		ifTrue: [ 
			keys
				replaceFrom: start
				to: stop
				with: replacement keys
				startingAt: repStart ].
		
	super replaceFrom: start to: stop with: replacement startingAt: repStart .