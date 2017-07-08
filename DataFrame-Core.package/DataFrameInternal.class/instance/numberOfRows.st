accessing
numberOfRows

	matrix numberOfRows isNil
		ifTrue: [ ^ 0 ].
		
	^ matrix numberOfRows.