testing
summary

	| summary |
	summary := self class new.
	
	summary
		at: 'Min' put: self min;
		at: '1st Qu.' put: Float nan;
		at: 'Median' put: self median;
		at: 'Mean' put: self average;
		at: '3rd Qu.' put: Float nan;
		at: 'Max' put: self max.
		
	^ summary
	