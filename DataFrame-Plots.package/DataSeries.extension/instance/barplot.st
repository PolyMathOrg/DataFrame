*DataFrame-Plots
barplot
	
	| uniqueValues colors |
	
	uniqueValues := self unique.
	
	uniqueValues size <= 4
		ifTrue: [ colors := DataColor palette: uniqueValues size ]
	 	ifFalse: [ colors := uniqueValues collect: [ :v | DataColor blue ] ].
		
	^ self barplotWithColors: colors.