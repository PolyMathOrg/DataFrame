accessing
replaceFrom: start to: stop with: replacement

	(replacement isKindOf: self class)
		ifTrue: [ 
			keys
				replaceFrom: start
				to: stop
				with: replacement keys ].
		
	super replaceFrom: start to: stop with: replacement.