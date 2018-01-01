*DFTools-Plots
scatterplotMatrixOn: categoricalColName

	| categories palette colorDict observedCols b label block lb |
	
	categories := (self column: categoricalColName) unique.
	palette := DataColor palette: categories size.
	
	colorDict := Dictionary new.
	
	categories doWithIndex: [ :category :i |
		colorDict at: category put: (palette at: i) ].
	
	observedCols := self columnNames select: [ :name |
		(self column: name) isQuantitative and:
		(name = categoricalColName) not ].
	
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
		color: [ :a | colorDict at: (a atKey: categoricalColName) ].

	observedCols do: [ :name |
		b metrics at: name put: [ :row | row atKey: name ] ].

	b build.

	"If there are hundreds of categories, we don't want to include every single one into the legend"
	(categories size <= 10) ifTrue: [
		lb := RTLegendBuilder new.
		lb right.
		lb view: b view.
		lb addText: categoricalColName asString.
	
		categories do: [ :category |
			lb addColor: (colorDict at: category )
				text: category ].
	
		lb build ].
	
	^ b