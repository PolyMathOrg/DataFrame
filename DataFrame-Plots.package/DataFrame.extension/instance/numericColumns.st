*DataFrame-Plots
numericColumns
	"Returns the copy of a DataFrame containing only numeric columns. These columns can be visualized"
	
	"It may look ugly, but otherwise it would be very slow on large datasets"
	^ ((1 to: columnNames size)
		select: [ :i | ((self at: 1) at: i) isNumber ])
		collect: [ :i | columnNames at: i ].