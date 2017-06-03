*DataFrame-Plots
scatterplotMatrix

	| n palette b label block lb d |
	
	n := self numericColumns size.
	palette := DataColor palette: n.
	
	b := RTScatterplotMatrix new.

	label := (RTLabel new)
		height: 17;
		color: (Color lightGray).

	b labelShape: label.

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

	palette := DataColor palette: 3.

	d := Dictionary new
		at: 'setosa' put: (palette at: 1);
		at: 'versicolor' put: (palette at: 2);
		at: 'virginica' put: (palette at: 3); yourself.

	b shape circle
		size: 3.5;
		color: [ :a | d at: a fifth ].

	b metrics
		at: 'Sepal length' put: #first;
		at: 'Sepal width' put: #second;
		at: 'Petal length' put: #third;
		at: 'Petal width' put: #fourth.

	b build.

	lb := RTLegendBuilder new.
	lb right.
	lb view: b view.
	lb addText: 'Iris flower data set'.
	d keys do: [ :k |lb addColor: (d at: k) text: 'Iris ', k ].
	lb build.

	^ b view