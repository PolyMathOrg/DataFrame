statistics
summary

	| summary |
	summary := self class new.
	
	summary
		atKey: 'Min' put: self min;
		atKey: '1st Qu.' put: Float nan;
		atKey: 'Median' put: self median;
		atKey: 'Mean' put: self average;
		atKey: '3rd Qu.' put: Float nan;
		atKey: 'Max' put: self max.
		
	^ summary
	