accessing
summary

	| summary |
	summary := self class new.
	summary name: self name.
	
	summary
		atKey: 'Min' put: self min;
		atKey: '1st Qu.' put: self firstQuartile;
		atKey: 'Median' put: self median;
		atKey: 'Mean' put: self mean;
		atKey: '3rd Qu.' put: self thirdQuartile;
		atKey: 'Max' put: self max.
		
	^ summary
	