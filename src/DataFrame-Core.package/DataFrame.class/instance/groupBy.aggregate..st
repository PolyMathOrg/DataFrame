queries
groupBy: colName aggregate: selector

	^ (self groupBy: colName) perform: selector.