as yet unclassified
offsetWithSpaces: aNumber
"Generates a string filled with a given number of spaces"
	
	^ (1 to: aNumber) inject: '' into: [ :offset :i |
		offset, ' ' ].