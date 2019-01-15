applying
applyElementwise: aBlock
	"Applies a given block to all columns of a data frame"
		
	self toColumns: self columnNames applyElementwise: aBlock.