initialization
initialize: aPoint

	super initialize.
	
	matrix := Matrix
		rows: aPoint x
		columns: aPoint y.
		
	^ self