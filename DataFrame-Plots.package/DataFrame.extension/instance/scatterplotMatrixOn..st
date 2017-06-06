*DataFrame-Plots
scatterplotMatrixOn: categicalColName

	| categories palette colorDict observedCols categoricalColIndex b label block lb |
	
	categories := (self column: categicalColName) unique.
	palette := DataColor palette: categories size.
	
	colorDict := Dictionary new.
	
	categories doWithIndex: [ :category :i |
		colorDict at: category put: (palette at: i) ].
	
	observedCols := self numericColumnNames copyWithout: categicalColName.
	
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

	categoricalColIndex := self columnNames indexOf: categicalColName.
	
	b shape circle
		size: 3.5;
		color: [ :a | colorDict at: (a at: categoricalColIndex) ].

	observedCols doWithIndex: [ :name :i |
		b metrics at: name put: [ :row | row at: i ] ].

	b build.

	"If there are hundreds of categories, we don't want to include every single one into the legend"
	(categories size <= 10) ifTrue: [
		lb := RTLegendBuilder new.
		lb right.
		lb view: b view.
		lb addText: categicalColName asString.
	
		categories do: [ :category |
			lb addColor: (colorDict at: category )
				text: category ].
	
		lb build ].
	
	^ b