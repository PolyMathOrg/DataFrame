accessing
numberOfColumns

	matrix numberOfColumns isNil
		ifTrue: [ ^ 0 ].
		
	^ matrix numberOfColumns