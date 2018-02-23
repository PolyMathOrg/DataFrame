*DataFrame-Tools
scatterplotWithColor: color
	
	| b ds |
	
	((self type == Number) or:
	(self type inheritsFrom: Number))
		ifFalse: [ Error signal: 'This operation is not permitted for non-numeric series' ].
	
	b := RTGrapher new.
	b extent: 300 @ 200.
	
	ds := RTData new.
	ds dotShape circle color: color.
	ds points: self.
	b add: ds.
	
	^ b