accessing
numberOfRows

	contents numberOfRows isNil
		ifTrue: [ ^ 0 ].
		
	^ contents numberOfRows.