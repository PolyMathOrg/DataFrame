*DFTools-Plots
scatterplotMatrix

	| b label block |
	
	b := DataScatterplotMatrix new.

	label := (RTLabel new)
		height: 17;
		color: (Color lightGray).

	b labelShape: label.
	b boxShape: (b boxShape borderWidth: 0.5).

	b objects: self.

	block := [ :k | k == k asInteger 
   		ifTrue: [ k asInteger ] 
		ifFalse: [ k asFloat ] ].
	
	b axisX 
		numberOfTicks: 5;
		rotateLabels;
		labelConversion: block.
		
	b axisY
		numberOfTicks: 5;
		labelConversion: block.

	b lineShape: (RTStyledMultiLine new
		dashedLine;
		width: 0.2; yourself).

	b shape circle
		size: 3.5;
		color: DataColor purple.

	self numericColumnNames doWithIndex: [ :name :i |
		b metrics at: name put: [ :row | row at: i ] ].

	b build.
	^ b