as yet unclassified
groupBy: colName

	| groupedColNames |
	
	"We exclude the column by which we are grouping"
	groupedColNames := self columnNames copyWithout: colName.

	^ DataFrameGrouped
		group: (self columns: groupedColNames)
		by: (self column: colName)