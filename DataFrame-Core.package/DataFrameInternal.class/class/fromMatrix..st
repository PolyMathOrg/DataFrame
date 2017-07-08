instance creation
fromMatrix: aMatrix

	| dfInternal |
	
	"We can't use Matrix>>extent, because it gives us col@row instead of row@col"
	dfInternal := self new:
		(aMatrix rowCount @ aMatrix columnCount).
	
	aMatrix withIndicesDo: [ :each :i :j |
		dfInternal at: i at: j put: each ].
	
	^ dfInternal