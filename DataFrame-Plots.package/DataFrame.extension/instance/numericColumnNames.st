*DataFrame-Plots
numericColumnNames
	"Returns the copy of a DataFrame containing only numeric columns. These columns can be visualized"
	
	^ self columnNames select: [ :name |
		(self column: name) type inheritsFromOrEqualTo: Number ].